Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com [115.124.28.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3931B3C1D4A;
	Wed, 16 Sep 2026 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580894; cv=none; b=S3r4C/7WVv7nciDA9M3Z5D4iZjao2/WlDKB8sdAbdM88rqCDauUCCODbmpOTKHzCI7/gFsUAMBoCrvZrtU+x5xLrAnGcMGhHdBMB3ug8afIeKOs/87Z9QbvYfw2zbi16UBJuoAd7oE8wAsdDu4KBho8s8fmvs4/i9jzHS7T1Grk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580894; c=relaxed/simple;
	bh=QbRXYjGNvsf0xB+2rKcnK29WvcsXFNL6eZyy1DumIxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0wRwrks9Sguq8B8ITM7yMaf91mZZntDGfQTaaQpSZ3ZdT8eRyqNTDrz2Tc9Bd67/2L2kY4wrshxVKBgcYOU7WpsWcI4GJqR+Qz3xdh5VF93BLC+MNBZepGWkj/ykOsrPr8PRDB4AF6xx+VlyVHekeRdJiNI3mUqdkucK+lDz14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=CvkpuqJS; arc=none smtp.client-ip=115.124.28.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="CvkpuqJS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789580875; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Y2JZrzkCZx1CPAM6WtC1KCfCxwy4eVbMVstrRzw+wqE=;
	b=CvkpuqJS1sMsDosT1BDYKIsX2UsCUW45RhaU93/a6hH43aIUsRDqmc8/Ver0wrO1y/2IsvdeZnlq+MLbUWXMxCUT5VYoSJ+F/tR/EWKupdh0x04DsiN2s2RLwqQ7flY+8ak4/5vsK/ztMR/JLNdf846vzFRRUGKybf35MFdhCYY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0544522|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0112997-0.00050524-0.988195;FP=1577559693999015619|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jFIg.TB_1789580874;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jFIg.TB_1789580874 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 01:47:55 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com
Cc: mmaurer@google.com,
	masahiroy@kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] module: close two ELF section-validation gaps
Date: Thu, 17 Sep 2026 01:47:51 +0800
Message-ID: <20260916174753.14870-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both patches come from the same review of the module ELF validator, and
both fix an out-of-bounds read of a section field that the validator
leaves unchecked on purpose.

elf_validity_check_sectionheaders() exempts SHT_NULL and SHT_NOBITS
sections from its bounds checks, on the assumption that a section with
no contents has nothing to dereference. The loaders that run after it do
not share that assumption: they read sh_name and sh_offset for every
section, so an exempted section carries an unvalidated field into a
string lookup or a pointer computation. Commit 9a5ff4568932 ("module:
validate string table section types") closed two such gaps for
.shstrtab and .strtab; these two patches close the ones that remain.

Patch 1 gives the undefined sh_name of a SHT_NULL section a safe value,
so the section walkers that follow read the empty string instead of
running past .shstrtab.

Patch 2 validates the sh_offset of the __version_ext_names section
before elf_validity_cache_index_versions() dereferences it, so a
SHT_NOBITS section of that name cannot point the extended version name
walk outside the module image.

Each patch stands alone and can be applied or backported separately;
they are grouped only because they share a root cause. Both were
reproduced on 704340f1cd0d with KASAN, and each is fixed by its own
change.

Fang Xieyan (2):
  module: Sanitize the undefined sh_name of SHT_NULL sections
  module: Validate the __version_ext_names section offset

 kernel/module/main.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.50.1 (Apple Git-155)

