Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294B5475351
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154886; cv=none; b=UIB4ClZsTf0mdl2jP5jxQSyM44OVV6h34h97ugGH3tu9OUN4qEyxOU+xdFDvzOPMdUqwdeDQy+fMI1lruAe7QkX3ZxWFz7SynYmC/WE6az+ET9e3Nu2QXHQ1zYFwZ85GfX8SKDVljQ4AvOU5LQkaPKI3WS7NgVj+SzPsUemijho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154886; c=relaxed/simple;
	bh=+/xqVXjvzWOHGSOuXp+sLWOT1M8dhFYIKDDTCG107sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKoPKI6nrjtyABiDU+/hE/CHPgxHptokih2xQ+1powhep0muk2TzNZrY4+nrwokhybOnMBa2KMb5IH7Fw2IczCYFEBmYT3IRbyTE3AoC/cQ47sIkbA4d0ITZRjhQ0tui7Khy36oBn6TOq+IvJSzN92Bmy2rorrma62w0wMv5xUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=NwQ54iec; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=azn4f5Xe; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="NwQ54iec";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="azn4f5Xe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DDA2B1D00033;
	Wed, 23 Sep 2026 05:14:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 23 Sep 2026 05:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790154882; x=1790241282; bh=9GHGA2mlWu
	/ss5NDOtOyoX3F/VZkrqWmW5sfbpPYHmE=; b=NwQ54iecOieV5FxJtLIZdALiOp
	DyjA71dlrzkSTg5/9GMGk83f2RgRq0aTmClPdBKksNarj3gOEFIgldYxYxTsvekQ
	uL/+ud9JEpFdN1k6AXM2MzCsFu21QDzYjaKxOsavrXwrxM0SPTgNTqAyuTlh0J8U
	Cnax+Ua2X3eGF9iFTffw0Vu5jvyLegTacUonKvPd4wANavE7aY8bepT5bIvbijmO
	gTu5xTd3B1loVrhBEnQkgBRyoKqR+rVLgFwbpdbaMuuY7Nv2ceYmaSCpw/QzN2D5
	L7zI7XZWIPa+sMg+qwXlsUOMvzOCXHEiY9lrR+EuuVLAToBE4imtsWLGxSzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790154882; x=1790241282; bh=9GHGA2mlWu/ss5NDOtOyoX3F/VZkrqWmW5s
	fbpPYHmE=; b=azn4f5Xer6bvNutacD2FdN6fcErMTGGJfw5/4VAeCZlACl8+rwZ
	R+xKNPkYrCUGbPYRtaIbAJGW1Nyzss+6BwX6gmnGc8aQOyuaqBebSodzWohtUd9e
	22frlgaVq8vE1d3xu9TpNX1tDOk6Qr/PZ0ESEi3KwsBT7FEeLrYzMfNi9aDT/C7t
	5AoHrSOYgqocfP1AvokPssT0m2ugTBcO2hDbum2Ft7JJYl+izW3boWA7bog+7NvO
	k/9BTlLjAgBSd53xPK3kaOwKXNvRKqGgtLp1qQULMRYlDEGK5Wrki+toCybqEDWv
	mrCc1AWJL/7gdSfbKNM57+pZiTmcY2mFdig==
X-ME-Sender: <xms:gpizao8X7a6asa7viPR7umdyhdv58HfnMEqUkfg1s5T7bH4zEwJNRw>
    <xme:gpizaoRRg45z2UfBrRC0D7IqDD2bNf7ofAZKAAxBrW0OLTfHDWlxN0fey0LjrBr0r
    oYLnAb5UdwCPgpojhXr8p6rWGxoOxN05DBZzfTH69QqKTcUduU>
X-ME-Received: <xmr:gpizatpXgWHH5lqYYLqZznvQQsBBpGO64bb8Q_LPHcSBeITpfCD4ZAmsp0ct>
X-ME-Proxy-Cause: dmFkZTGAXO2hJdhEAbO+WYAMqYSLoa7ezBSaXKUoVFy1XYubHY0dwkXQZJoVEX5kQ+jtv4
    9IEm6Ifk+WxYpzVA9XI3fvyVEdF3DlcPwmLX2K7ELLz5SIjhaE7YhPpslW+JH8AvAsjo06
    0iWA/97CcqgK2+3FswUNtDkXun4JWzBgGr9bji34PYh5GiRpfRypSDXQRN958txXHDelnF
    j8grY+6U6ZNRzK6/jWANR9f7OU3KPBFWN497uuWxRQi3BBYfsiOX10EA7xFYHkVM4xNHhd
    qdAau7sTpWP8JEOXIrz0cX1IlnvTEWLK8vjjUzENxRColNosVX6WqFXBsSmSvQ3y68xpgo
    mZL9C2LNbdbDodMlE04jAWJggemRTjI+X2et/x0oDHBsn7yre9cYJ42K2Uh6BIYWDJer//
    oBUjvzn2/o2xgehgc53/Yw1egs5SIoweqw81X92hQd19+LHXoW5qXN+bx649gUS3tFX2nn
    mBHCHJHHlVuSCWr6n9Be+ePf6A5txqsNByPbMa9mB6YTxcF1QPXVjmCAooj2oLaB0rBTRb
    fU2d74GDspJij6qWjhL/qV6JZaW0Iv7LQ8k4n6kWys0TuFnau50hY3TEAvgt+Q/por60Jj
    yf8vYR66g1xkdjWPCcvAPMwZPTLxvG4Wm9eBD2xp2th6Ja2gr0X7kVE1A1/g
X-ME-Proxy: <xmx:gpizalOjq3UgGK0Xk61yW92FKP82Sg8WWubgH_jTKSwQPFPPmr5ZPw>
    <xmx:gpizajykpu0sqqto_sqayxGdZzT0uZCcyBVFUEUBRIwNtb6EPatAqQ>
    <xmx:gpizapwTWDaLlxJ_cISreF7DOr892C7i45sboqqmco5gYKDvNb7whw>
    <xmx:gpizakKd6hZODEEZ-YmeMAy3q9hCGwcytwU7c-HjaV0EVJtFq7bipg>
    <xmx:gpizasz2sqq5HJRsFooPTpF8lIvsTeRASqST9eTLHHvCQK3sJqRNWJXi>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 05:14:41 -0400 (EDT)
Date: Wed, 23 Sep 2026 10:03:20 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>
Subject: Re: [PATCH 6.18.y 1/3] smb: client: fix WSL reparse point uid/gid
 override
Message-ID: <2026092315-dayroom-catty-be31@gregkh>
References: <2026092249-multitude-amigo-b729@gregkh>
 <20260922194812.85938-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922194812.85938-1-sashal@kernel.org>

On Tue, Sep 22, 2026 at 03:48:10PM -0400, Sasha Levin wrote:
> From: Paulo Alcantara <pc@manguebit.org>
> 
> [ Upstream commit cd2b2b57921d4caa7875e83198bb2aa71254328b ]
> 
> wsl_to_fattr() unconditionally overwrites cf_uid/cf_gid with values
> from WSL extended attributes ($LXUID/$LXGID), ignoring the forceuid
> and forcegid mount options.
> 
> Fix this by initializing cf_uid/cf_gid to the mount defaults and
> gating the $LXUID/$LXGID EA parsing on forceuid/forcegid.
> 
> Closes: https://sashiko.dev/#/patchset/20260906190803.667489-1-pc%40manguebit.org
> Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Paulo Alcantara <pc@manguebit.org>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Bharath SM <bharathsm@microsoft.com>
> Cc: stable@vger.kernel.org
> 
> Backport adaptation for Linux 6.18:
> Keep the existing S_IFMT clearing from 99daf7535445 when adding the
> mount-default UID/GID initialization.  The stable branch already has
> that file-type fix, which followed this dependency upstream.
> 
> Also include the two wsl_to_fattr() mode-read conversions from
> e1aeaf79dea5 and include linux/unaligned.h directly.  These are the
> remaining context changes needed for e1253a82bb4c to apply unchanged;
> the other helper conversions are outside this target's context.
> 
> Stable-dep-of: e1253a82bb4c ("smb: client: fix fattr leaking on wsl_to_fattr() failure")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/smb/client/reparse.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
> index 6ec6b8c46ba22..c87b282da1ce9 100644
> --- a/fs/smb/client/reparse.c
> +++ b/fs/smb/client/reparse.c
> @@ -6,6 +6,7 @@
>  #include <linux/fs.h>
>  #include <linux/stat.h>
>  #include <linux/slab.h>
> +#include <linux/unaligned.h>
>  #include "cifsglob.h"
>  #include "smb2proto.h"
>  #include "cifsproto.h"
> @@ -1109,10 +1110,14 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
>  			 struct cifs_sb_info *cifs_sb,
>  			 u32 tag, struct cifs_fattr *fattr)
>  {
> +	unsigned int sbflags = cifs_sb_flags(cifs_sb);
>  	struct smb2_file_full_ea_info *ea;
>  	bool have_xattr_dev = false;
>  	u32 next = 0;
>  
> +	fattr->cf_uid = cifs_sb->ctx->linux_uid;
> +	fattr->cf_gid = cifs_sb->ctx->linux_gid;
> +
>  	fattr->cf_mode &= ~S_IFMT;
>  	switch (tag) {
>  	case IO_REPARSE_TAG_LX_SYMLINK:
> @@ -1150,15 +1155,17 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
>  		nlen = ea->ea_name_length;
>  		v = (void *)((u8 *)ea->ea_data + ea->ea_name_length + 1);
>  
> -		if (!strncmp(name, SMB2_WSL_XATTR_UID, nlen))
> -			fattr->cf_uid = wsl_make_kuid(cifs_sb, v);
> -		else if (!strncmp(name, SMB2_WSL_XATTR_GID, nlen))
> -			fattr->cf_gid = wsl_make_kgid(cifs_sb, v);
> -		else if (!strncmp(name, SMB2_WSL_XATTR_MODE, nlen)) {
> +		if (!strncmp(name, SMB2_WSL_XATTR_UID, nlen)) {
> +			if (!(sbflags & CIFS_MOUNT_OVERR_UID))
> +				fattr->cf_uid = wsl_make_kuid(cifs_sb, v);
> +		} else if (!strncmp(name, SMB2_WSL_XATTR_GID, nlen)) {
> +			if (!(sbflags & CIFS_MOUNT_OVERR_GID))
> +				fattr->cf_gid = wsl_make_kgid(cifs_sb, v);
> +		} else if (!strncmp(name, SMB2_WSL_XATTR_MODE, nlen)) {
>  			/* File type in reparse point tag and in xattr mode must match. */
> -			if (S_DT(fattr->cf_mode) != S_DT(le32_to_cpu(*(__le32 *)v)))
> +			if (S_DT(fattr->cf_mode) != S_DT(get_unaligned_le32(v)))
>  				return false;
> -			fattr->cf_mode = (umode_t)le32_to_cpu(*(__le32 *)v);
> +			fattr->cf_mode = (umode_t)get_unaligned_le32(v);
>  		} else if (!strncmp(name, SMB2_WSL_XATTR_DEV, nlen)) {
>  			fattr->cf_rdev = reparse_mkdev(v);
>  			have_xattr_dev = true;
> -- 
> 2.53.0
> 
> 

Does not apply :(
