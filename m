Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099696;
	b=t0lEfM0qopOpafQmP9l64wAlty+8xoZWvD56McQzsKYs9uOxhYHFuZJjY0OKeBev1nyN
	 Az0U3vzUe++R+Kp5ECy/rBWO8W52Y5WXxGGudI/OwHCE9Hh23DhQ02O3wWZ8xL2Vb0G8F
	 3K/5fIQJ08iayN93n7Q4LJfUTSVxEiHEm4bVR1EGZZ4i/7PfjBfkhRVjirYv5U6P+U6fK
	 ciWFL5DrVaDNXd+0uzp/gaYnFpmzmMEHOH7NTuixkHwyYaUl/+0QPiSm3oHdxMnuC0Nva
	 AgH8oOGqO/UTk8EF4M27FP7tyZlFkrsKQXTxLnm1LwJzhVhKl/qerPx20qTI6fwsS/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099696;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=FZ6TvTj2l2k7OQkE238MtaeNlSEmFIdYntk0TxQZ5a8=;
	b=tsJmL/+aFUZOiWguvjdr4vgwJkFUH0y5qcvNfuGAqv1GgifeyalQLOv6i+X4L6NQ/hv3
	 UkPJcsJPAPtCTIJAvGFRaPUW2P8LloI4dTVARLSfHXt+21FV4+hZHKd6mbarih14wPRyf
	 Sowe87Fon2OkOepoHzyo+I4fdM7mx0L/05pPSt/E1nG0yerYxpOni/OQ9jQXjLGAbIRCk
	 i5Srf+CVdR8mSCTD9kRX7nNDhwXmgwI5PjNFF32/q4bTAAQeWc2iriF6IuxRbTN8RYTMY
	 MrEYN/r/MdHFsPb8Axe/074FbBy2RdfOfxjREf9Xi6lvw5Rt0CJtIFLSEFoL6BCYlTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=cr2iEDjy;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A58F606CC07
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A58F606CC07
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=cr2iEDjy
Received: from trampoline.thunk.org (pool-173-48-114-214.bstnma.fios.verizon.net [173.48.114.214])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AJElcB7017979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1795099661; bh=FZ6TvTj2l2k7OQkE238MtaeNlSEmFIdYntk0TxQZ5a8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=cr2iEDjylkvib2YyFvJByFT+p2xHROA328ySzQKeDa0hKULR2u3JnSeopsgrZtMdp
	 px6PEfEjvGNCCqWXTbzlDfKJemiNP3SZ3vGmeXvg3TjPGRjJd5kFkvHpoutQguy/pY
	 GrGFUJQzugknf9Wa8zSnC1lPudH2E/0qXiCAXNzMNVlZuSP1oXL2nQsjb4c65XtzDv
	 gLVwAGRHfjglkWpzq3i+sCaUyvsBTb9ZjltAR3fluBYxHksHDlBxWU/gakvr5WWwOB
	 DwrRYy3SmXFOMg1kIMDayY6eiWCrKLSwe4KKSDomv7s9GhOfG5J+P9HFTBnUcifxzN
	 xPWMLF2Ad2Z1g==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id EEC4B2E0158; Thu, 19 Nov 2026 09:47:32 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Hungyu Lin <dennylin0707@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        libaokun@linux.alibaba.com, jack@suse.cz, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, yi.zhang@huawei.com, djwong@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ext4: preserve force-fsck requests across unmount
Date: Thu, 19 Nov 2026 09:46:49 -0500
Message-ID: <179509948720.1938961.7467339538966692480.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027035857.72265-1-dennylin0707@gmail.com>
References: <20261027035857.72265-1-dennylin0707@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 27 Oct 2026 03:58:57 +0000, Hungyu Lin wrote:
> EXT4_TUNE_FL_FORCE_FSCK sets EXT4_ERROR_FS in the on-disk superblock
> but leaves s_mount_state unchanged. On a normal read-write unmount,
> ext4_put_super() restores s_state from s_mount_state, clearing the
> requested flag.
> 
> As a result, a successful EXT4_IOC_SET_TUNE_SB_PARAM call can be lost
> before e2fsck runs: after unmount it treats the filesystem as clean
> and skips the requested check.
> 
> [...]

Applied, thanks!

[1/1] ext4: preserve force-fsck requests across unmount
      commit: fe66a3e2a6627bef578137722f430bd633dee3e5

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
