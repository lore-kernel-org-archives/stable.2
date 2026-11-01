Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530123;
	b=EHGLpp3c9ThriXvBpgOdbAec4T/kHiC3fYwFSRX9XkMFUGyXtJhd3F08Ie74ZkXd+CKv
	 wdErBIjyhZ/T5fM39TsjUONvTK2L1QUVSwte9wv7DLVSOxnpS/zAnUvMH0DHxXsJokIbz
	 Y5uwuZMJQAg1KQHI21ucZP5BLrIOCSeMbNEBolXnnMh0E5jkX2Hl+YEgmG9QEYSjdatnp
	 xIe7lLZEqKJZpWQ17YDMNubUYTZLst+NzZlewq8sbrAxBkxWZwX3wwDtmnsspiY2MFXEw
	 hh41Xxxdf0u7km5boU0EgRqgCKXZjDiwabKw6W/WPnTbp9G99vcagk+fu1vca4e1/rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530123;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vUuYB/b4qAlVy17rDjkH2MMem8gIyNHOZnxT7q6yqts=;
	b=D6W4NYnrnqyNlPzVehLTpzUmfUgh42f3n4hPkGUdXemdhDhQBuG7nfnFMHh1Du3cT/BA
	 JrXunHvDGc8BW4YhEoAt2F8qxZW5sccGXAhaacdvKG6WDc6E8ZmisBI8oqFxZWfKxeGCT
	 /j15vxWNwQbtILctLo2OGmklNK/iego4ozCi1413R1A0JnOaLQzLNlMh5kbVKD/pCknvb
	 LiVDsIrLuc/qrX/SmHRJmGRBILnajFsiJ0RNyE2UzPdE0B4gzF+vMN3fLO8mJW/RORNq/
	 YVAZOskw/RhnbUQutyVMlAZdAiVTdvS4fucZkxE9TpUjSOUAJBgsBJbLminopW6xc7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QP4VshIu;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE5C606A324;
	Sun,  1 Nov 2026 10:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFE5C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QP4VshIu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=QP4VshIulSWgbtkceG+EikOgflJ+S3jBif/7NR/vCEqUD9TRoA0O6eh7E/oy6RE2nWPnDKK3nCemF
	 LzXchgh0U6weTAab3xVZ5YvNEiLHWkMkR3LdvnLymmDZmnPpIW0vJoO+Z4du4StmGyAIex8jAeKmtB
	 cfdR2eoOl8nntq+w=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26ae71900cb9-bb486;
	Sun, 01 Nov 2026 18:48:36 +0800 (CST)
X-RM-TRANSID:2ee26ae71900cb9-bb486
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56ae71902977-a846b;
	Sun, 01 Nov 2026 18:48:36 +0800 (CST)
X-RM-TRANSID:2ee56ae71902977-a846b
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org,
	yana06070@163.com
Subject: Re: [PATCH net] ipv4/ipv6: preserve multicast filters after a failed source leave
Date: Sun,  1 Nov 2026 18:48:24 +0800
Message-ID: <20261101104804.8258-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030063603.697510-1-yanxia@cmss.chinamobile.com>
References: <20261030063603.697510-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

The Sashiko review of this patch has two open Medium concerns [1].
Both describe behavior this patch does not change. My reading of each:

1) Empty-filter mode switch before the allocation in ip_mc_source() and
   ip6_mc_source().

   The mode-switch block is untouched. The diff only moves the sflist
   dereference up and returns early when no source list exists for a
   deletion. Add requests still reach the block in the original order,
   so a mode switch followed by a failed allocation is preexisting
   behavior. Restructuring that path would grow this stable-targeted
   fix well beyond the bug it addresses. I'm happy to look at it as
   follow-up work if there is interest.

2) IPv4 leaves a non-NULL, empty sflist after unblock, while IPv6 frees
   it.

   This patch changes neither when a source list is freed nor when it
   is kept. For a non-NULL empty list the new early check is a no-op:
   the delete path already tested !psl further down, and the mode check
   keyed on pmc->sflist before this change. The asymmetry predates the
   patch. Unifying it would alter observable behavior on a long-stable
   path, so it looks like a separate discussion to me.

No respin planned for these two. I will follow up if a maintainer
sees them differently.

[1] https://sashiko.dev/#/patchset/98602

Best regards,
Xia Yan


