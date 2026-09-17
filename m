Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A63DAAC9;
	Thu, 17 Sep 2026 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671991; cv=none; b=SH0mSlRlWgT669UZp/hK2eBWSclUYWOlu3u2BbdKt7ZGa2ai9dHqRU7k9mNngeCFK6T9g/lCyBi1HChz9O4twYU2kqt1ewtFn2ZhUpODHAF4xukpEnPxHpQfJ6Y/RgVJAbuamhbWyzUvqODjIN9OJhExQvRVhpo4uN08BQsnjU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671991; c=relaxed/simple;
	bh=wrsIHoHOBGnWfGLeM249ztUUjWOMhH73kU4KEpK5gfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ny+E6S8h7Ls5hnXu4OFNo0aKlAHEwNyh8o42gNxNejMaXJKzUsxa3hoSIbPzlN6mbzZUyLQ4tW4QF1f8UvlXqzekgp8X809IkPOO2852CRSHt84dDIKL0tnWQ+Q+boLsHmVnfaG9HXE0gsuFzI/lS6Qg5TH9xfbEWce1roeiweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=TujI0yVl; arc=none smtp.client-ip=115.124.28.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="TujI0yVl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789671980; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=A8TRKg7M1b4TmknYpxAi51YwWqt01cT9L4eNEJKUU9k=;
	b=TujI0yVlu8lBxvfgdIUMISxSIP+aCH277oB1GcNoh7qmu5reKdvXbS4DF1eSomvzYa+Ks7uTZqVn8ZptWiIsE/XHzkYyZSIuodn26DY6Edv/YD+/uRR2NU9eIEX7UTm5Sx09tnQir6bLvegKkLaolM/7zZuCeJjkb2a81+y8NcU=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04503161|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00639929-0.000475032-0.993126;FP=1577981889284212419|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jG9ODf7_1789671978;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jG9ODf7_1789671978 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 03:06:19 +0800
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
Subject: [PATCH v2 0/2] module: close two ELF section-validation gaps
Date: Fri, 18 Sep 2026 03:06:16 +0800
Message-ID: <20260917190618.94759-1-fangxy@xiaopeng.com>
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

Patch 2 requires the __version_ext_names section to be SHT_PROGBITS
before elf_validity_cache_index_versions() dereferences its sh_offset,
so a SHT_NOBITS section of that name - which the validator exempts and
which holds no file data - cannot drive the extended version name walk
outside the module image or make it read unrelated bytes as a name.

Each patch stands alone and can be applied or backported separately;
they are grouped only because they share a root cause. Both were
reproduced on 704340f1cd0d with KASAN, and each is fixed by its own
change.

Changes in v2. v1 was posted here:
https://lore.kernel.org/all/20260916174753.14870-1-fangxy@xiaopeng.com/

 - Patch 2: require __version_ext_names to be SHT_PROGBITS before its
   sh_offset is dereferenced, instead of bounding the offset. Review
   pointed out the offset bound is narrower than the bug: an in-bounds
   SHT_NOBITS section passes it and the walk then reads unrelated file
   bytes as a version name. The type check rejects both the
   out-of-bounds and the in-bounds variants; the reproducer now covers
   both. Details in the patch's tear-line notes.
 - Patch 1: unchanged since v1.

Fang Xieyan (2):
  module: Sanitize the undefined sh_name of SHT_NULL sections
  module: Validate the __version_ext_names section type

 kernel/module/main.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

-- 
2.50.1 (Apple Git-155)

