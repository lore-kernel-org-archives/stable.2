Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A533DD879
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274311; cv=none; b=q02AXpAjwwIBHqvfXbWSNnpSj6F0lsff3d2AlxeUGETN93U6oBG5NjyeXofydgJjZPHZXUX8hC8heZNll/RGh9RMoLeIhLVR0osVBrDTfC6rCLGRNRxXhw6mKhXMm1IR8DLFcilMtTvgej/I1RRG5wuxeJj3pSM+hVP2KLLVWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274311; c=relaxed/simple;
	bh=DS3sT0PCJhAHSfaYxcG/8U2QWUHNk9h4jX8tw/kTPZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=hNCF3GHWPkOcvqMTq4yTwY3W14I5n40FKniO3MZx9cUDGP3PtJmJYfI9oIui0xFH8pj9dk9LB4sNcinuiurq4oMdHjB2sopvi0NzybaBymTNw/hNKvaQrC6t79YrSWxDQkaAAVQkOSGXH3CH+3mx1eYSjcUkw5ngs9I7z+dOp/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=jmofvWqU; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="jmofvWqU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1791274308; x=1822810308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lef0bU8eYKREgaUFcHv9x3HBKOzPkQaOBP5GOOV6dLw=;
  b=jmofvWqU+cC6asMcO0VOM7zngNMiAErCtV7Tc5VM5fLDJT/cJaZZUfEZ
   RqumyImmy/8jt2kAiLz4pUs/ipgVMTy/xz3j6W3z2p3JDUByxgbxwpoLr
   9NdZpR6rzb0v9rorXctMaaLF7QDjdReHIDdD7m5gBaChXZ1lE7ICkDx5G
   JOnAXEvEkqVhpckQyXZaQSIjypwFbwQYqaNUW1f2ZDTrtxUeFs8kzLSK3
   olVCSHlv6w0J4uHoVoDtkE9ZNytb7WjX8TBW0L+Ty9K8ZkpG9Y3IPSTtN
   aL/B/pIWcmpiiBTCPkTF9o020HiIVDe8WMXTI8t+p61GrN9a1NxtEfYKg
   w==;
X-CSE-ConnectionGUID: qhMaDwdBSJC7LSMYnQU+5g==
X-CSE-MsgGUID: Xjk5j99WQAOtboNdVo/M1A==
X-IronPort-AV: E=Sophos;i="6.27,143,1787011200"; 
   d="scan'208";a="30025167"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 08:11:42 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:4999]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.113:2525] with esmtp (Farcaster)
 id 125c3df1-debf-41bc-a821-6e5c9d31405e; Tue, 6 Oct 2026 08:11:42 +0000 (UTC)
X-Farcaster-Flow-ID: 125c3df1-debf-41bc-a821-6e5c9d31405e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 6 Oct 2026 08:11:42 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 6 Oct 2026 08:11:41 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: Sasha Levin <sashal@kernel.org>
CC: Bjoern Doebel <doebel@amazon.de>, <stable@vger.kernel.org>, Jiangshan Yi
	<yijiangshan@kylinos.cn>, Namjae Jeon <linkinjeon@kernel.org>, "Paulo
 Alcantara" <pc@manguebit.org>
Subject: Re: [PATCH 6.1] smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
Date: Tue, 6 Oct 2026 08:11:19 +0000
Message-ID: <asStCruK73iccnIs@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026-10-03-1-daily-reply-0003-re-smb-kill-suid-posix-clause-6-1-v2@kernel.org>
References: <20261002145450.3926570-1-doebel@amazon.de> <2026-10-03-1-daily-reply-0003-re-smb-kill-suid-posix-clause-6-1-v2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Sat, Oct 03, 2026 at 06:32:46PM -0400, Sasha Levin wrote:
> > +	if ((attrs->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID)) &&
> > +	    !((cifs_sb->mnt_cifs_flags &
> > +	       (CIFS_MOUNT_CIFS_ACL | CIFS_MOUNT_MODE_FROM_SID)) ||
> > +	      cifs_sb_master_tcon(cifs_sb)->posix_extensions))
> >  		attrs->ia_valid &= ~ATTR_MODE;
> 
> 6.1 doesn't have d413eabff18d ("fs/smb/client: implement chmod() for SMB3 POSIX
> Extensions"), so the ATTR_MODE handling in cifs_setattr_nounix() has no POSIX
> branch. On a POSIX mount without cifsacl, the posix_extensions clause sends the
> kill-suid mode change into the DOS READONLY emulation instead of to the server.
> The bit is never cleared on the server, and in some cases (chown/chgrp of a
> 04555 file, or dynperm) this sets or clears the server's READONLY attribute or
> rewrites the local i_mode, which upstream never does.
> 
> Could you send a v2 without the posix_extensions clause, so the check matches
> 6.1's own CIFS_ACL/MODE_FROM_SID condition for ATTR_MODE, and say in the
> backport note that d413eabff18d isn't in 6.1? The cifsacl/modefromsid and SMB1
> unix extensions parts are fine as they are.

Thanks, will do!

I'm guessing you found that via some kind of tooling - would you mind
sharing so that I can make sure of such things ahead of submission next
time?

Bjoern

