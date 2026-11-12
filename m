Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794454159;
	b=CnhnKD+we6dXJ6FeZzbG9l9VXkSpax6Yn7FTEbPXbVavX+djQISnLFcDFR5lwbKGLVm2
	 CtfrxGitox1h5vS5JRxGEiImQ1zknMPL/ZagMHAdQNbBB4dSl/oM2yYLiWKG8h0mHHTZe
	 uobvXkOmSzW5DgIZo4uVHIjRA8imYgNvJkQducCkWgOXukZrkeabCetb+R1IcxRKfLS0g
	 xk4yppAFrmF/B2lO/QwGtLzu/DpEHsVDztYiPnWSM3moPhM5tNdZAFmlcS6+ndEmlvByC
	 F8znWzOPAYuEBTZNHCsi6GC3HX0eWBh+/fvG75nFJOBfGCWzxJxtQ+z0yMNJ5qbBrYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794454159;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KKfu9jTS/RUOusy9Q1UFKxQ2pIS8vt+0hv3b0KbLhC4=;
	b=Xt4S0bxgHQiyL7OFgcVAbqW1JYtBvZpUybiD63RdI//sdbLslotJrnTuzeB/lOcfym9T
	 0zUNJ9P3CMSVXwYB5FUC8ZHRWJSRCVlm1uPavyieW7BZ2QgrwF08u0q9VmtZ7D45w/116
	 z12yKYFrdpYQPQxQ5NWHnPLnYLo7t4C3TaWcXMuUf4momf/UYEiOH3Zr6vqKkVihJnx4h
	 8tP8V2EVTc37whywkZcXSum0ju2byIzmcr6CW2y8rFm2q2x8WTo3PsUREvKSjWPZ0a54R
	 6EtueZAwfJHeQLsohZ+2noVly+1DfvOAjdiPcbZlqmDQ5O9CnllfUsAZa8Vs4Qzjqsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=jWoVuFzf;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03DF606A31C;
	Thu, 12 Nov 2026 03:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C03DF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=jWoVuFzf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794454152; bh=KKfu9jTS/RUOusy9Q1UFKxQ2pIS8vt+0hv3b0KbLhC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jWoVuFzfJ2LYR6AK4mVk11XkNENZwm5e1IwlJT+4HegsooS6RRxVKSJQa9SQ0cNFc
	 2lr9yja6wLl6WpYucNCsR9IrvHgMFynVXNiWjuHza3gUS8yUegy2yyKtq/KhAmBTg9
	 GKrZJjZqdvZjRzHLHYrrHN2Dzj2crGahdbdyzFsw=
Received: from xkeyc-nixos ([119.97.45.41])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 7479860E; Thu, 12 Nov 2026 11:29:07 +0800
X-QQ-mid: xmsmtpt1794454147t3afruan1
Message-ID: <tencent_A4058D24A69C0C118306749F106836CC2406@qq.com>
X-QQ-XMAILINFO: MJf32pulH4811grMrkLSNSYwvhpy2gTvFr27/m4Z9gczzLpWeLzIv+raJk49Uu
	 bSlJM6c/uc7D9RRdajzEVJTKAeiA82zeGAigfIKLTd5g+OeUbWjS8E6EhrTVEpRilaTQsWv7ta2G
	 +REOVlMbQMkBkLOBrk6abem2r+8Oam/IMpltRzMHxA8n6xR9hrBM2w/qiEBr2Jmqt3nA4VbF/EAe
	 nJYExGYlyAjyRn80GpBbuWcIaZ8rHk5gom/85WEMcnqNHPf1Ca8um5TsfO32Sre0rfb7c7r+7JRJ
	 eiiMY8sj49wtTeyFnfelF8cJfDc2cO0PAm1d1T3s585fj4z+qk5kcbvenfZ/DSb1KJlGD9SmzjXP
	 qpOmorhqRwP2Lxi+ZVlrGUYrrhqY6quWpdPASyaW+lI9Q4is6o963lMcSKFTxq9z+qRVeESKcTqA
	 jMboEdaS7l3Khr0iGWVoEusw0FU4Wy1aHyOF7NWNHAK4rMVUHL0QztGzpzZERzAZxDThbqwxv//d
	 HiDxdQa9OZXOiR2hGWECFwvGsWE2cCPpYZqRq5ob4zfZzf/vjGZRbVcztu0eERU5bIbTVKr+2x/y
	 a/Dt6mIC8prZJKhGAcq8Nwk8V94xyKpSnugkoL/7K7APfUuP3VfPJfMOJc/NDw9XgdZyejVY7yC9
	 OkNrfVTCsJ/niB6wA8/Q9zphHI+xIBAGFzcCZbdQwlB6AZVu4F9XbTsUVOdFX4S2DATXV75c2jGk
	 jwzxqLO/TTBTj2tntD+JWwz7CAPxVVPoK/pXBx6CVbVVnkrUeaZEFamHPvcGu/ZSQbkHnNuqufKK
	 MPZkp12mzZgVgTSr2jhB1Kr85xXdUdiwSp8gBHpbCdwwn9Kdk09e/cSZXB+TWrt5WxBjAnUyDCFT
	 3vSVqQRFGe2Mx4p0K2NgDDACuj6B2zTFxsOrTwb4rlMqEQuYVtyUIVJhj34Y3GqTOGhX6WrSItJW
	 gxgvkhsKU0ZG+yzasKg1EP0iiOnWWAXVZ8gIRyO1K73Upp3xPg6OfXyk/Lb26IGmzMZQmNg/rkXO
	 1tiBn20g==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: xkeyC <xkeyc@qq.com>
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ntfs: don't let a fatal signal interrupt metadata reads
Date: Thu, 12 Nov 2026 11:29:06 +0800
X-OQ-MSGID: <20261112032906.34927-1-xkeyc@qq.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <avEqgxgLl17nq8SU@hyunchul-PC02>
References: <tencent_2859327A0C68D0D0429ED90F931234059808@qq.com> <avEqgxgLl17nq8SU@hyunchul-PC02>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hyunchul,

Thanks for the review.

On Mon, Nov 09, 2026 at 11:05:55AM +0900, Hyunchul Lee wrote:
> Could you double-check the Fixes tag and Could you confirm that
> xkeyC is your known identify for the sign-off?

You're right, the Fixes tags were incomplete. The directory index lookup
in ntfs_lookup_inode_by_name() comes from 0a8ac0c1fa0b ("ntfs: update
directory operations") and ntfs_bdev_write() from 5218cd102aec ("ntfs:
update misc operations"). v2 adds them, plus the commits behind the
mount-time reads that v2 also converts (see below).

Yes, xkeyC is my known identity. This is my first contribution to the
kernel. I use the name xkeyC everywhere online, for example
https://github.com/xkeyC and https://huggingface.co/xkeyC, and it
identifies only me, so I would like to keep signing off with it.

> The read when writing to non-resident stream should remain
> interruptible.

Agreed. v2 keeps that read killable for named streams, as
ntfs_inode_attr_pread() does, and does not call ntfs_error() when it
fails with -EINTR, so an interrupted stream write no longer turns the
volume read-only either. I added a test for it to the reproducers.
Without the patch, an NTFS_IOC_STREAM_WRITE killed partway through made
the volume read-only on the first run:

  __ntfs_inode_non_resident_attr_pwrite(): Failed to read a page 6 for attr 0x80: -4

With v2 it stayed read-write in 20 runs.

> Other paths still using interruptible reads include $LogFile and
> $MFTMirr checks, $AttrDef and $Upcase loading, bitmap scans through
> ntfs_get_locked_folio(), and ntfs_bitmap_check_used().

Thanks for listing them. I had left the mount-time reads alone on
purpose, but an interrupted read there is not harmless either. Killing
mount partway through made it fail in all 20 runs, with bogus "Failed to
load $UpCase from the volume" and "Failed to initialize attribute
definition table" errors. From the code, an interrupted read in
check_mft_mirror(), the hibernation check or load_and_check_badclus()
would instead mount the volume read-only with a $MFTMirr or $BadClus
error. My tests did not hit those. v2 converts the $LogFile, $MFTMirr,
hiberfil.sys, $AttrDef, $UpCase and ntfs_bitmap_check_used() reads too,
and with it the killed mount succeeded read-write in all 20 runs.

I kept the bitmap scans through ntfs_get_locked_folio() as they are.
They only read, and their callers (free cluster and MFT record counting,
and FITRIM) skip the page or return the error without calling
ntfs_error(). FITRIM can walk a large part of the bitmap, so it should
stay killable.

I'll send v2 shortly.

Thanks,
xkeyC

