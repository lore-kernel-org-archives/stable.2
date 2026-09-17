Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30C04C33E1
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640180; cv=none; b=G+HM4IEnO1RE+TCyzABvFfxHIEFBdRPMDmX4xmOKtHXjW7bX1PUd4jH5Yy9r3eXX04hiYb0/CQB7+Gy0FP9H5akFOYsn7Eaca23UpTN7CSFshxeaOe1vgE+E6w5athavhljJQTcCHYo+1o40M3Xk4g8Qap1aNt8wlZTDTazyeYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640180; c=relaxed/simple;
	bh=A9ROpBunIUOhbSKum5EYPENnQT7FDeEMN4tTV7qBAKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwtRwUeGXzvp0gKOjACg+fIQSJsWT2hgivFJ+n9qWIOPtFBr/1I9HAe1WqDFFde0ZGsXbz+0uFi7g601NYu9ZflwKXfuw+Uq5IZQ7e2XIEfldjsw9QQvgzMJg0lY1lSpEv2a79rIkdm0qGBMkXyAIZk8JFJj3OyyPEdiG8jmBWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=lIPTQecs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UjUrbguB; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="lIPTQecs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UjUrbguB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 59E947A0149;
	Thu, 17 Sep 2026 06:16:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 17 Sep 2026 06:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789640167; x=1789726567; bh=OsxLN3VZCz
	Jt9kvW9KBuhWCO5jdp8jRYq95otzOrb7E=; b=lIPTQecsU/T81ZIpDr7ck0UJ74
	I62u+sQefSOrMXNXOUiSI9Aba8woPMjTdAb+8r0TkUQ1ARdTD6ygt3sRHmkArmJh
	KPTWKMViAYbc7LlDaCgssF0/Y3mabxDH/9c+83itfxclwuZSo18OOZwzbbk96+uX
	Ue9bxsGa7fk+zba6DEk+QpmHLGH0nne7cy13UO7DolJCNAOX1CZMOleye8H4zJz+
	vIO0Fzz6a3RffkAXpgBhIYd8QLgzocPfmd0C8ti2qzGKYBfKV3pfigLqXrR1w0jV
	FVTIUAnbxxNTlgxWuM6q8yzv5IoTXJ/9EQ82oH0HGiQsf5gJlneSOwL4ZutQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789640167; x=1789726567; bh=OsxLN3VZCzJt9kvW9KBuhWCO5jdp8jRYq95
	otzOrb7E=; b=UjUrbguBvriRChXd5hpBN3eVldEAe0Dr+CmKQHsKxbwl3VK7D1u
	x7R/6RaAnJuORkPmxDh07mA4ziebscPlnFDCOosMQ8sfdGnk1hlaTY5Th45s3Kjs
	VIOrQTGMwJEHDHZ51vV2p+UqJ6BPv6Lf9uRRITjlJIwJ5nJTDZ798x+dJfB9jc6+
	MBqYSB0Epyr/JhH6gBmvHvP77JX0pp1pDukrnVBEVIQa2ApJW24crK7zVzBQXLUW
	oTtDo2mRiHYNonGUoRdgb2lfAfimu0D13sbmOA3sl2buL9MoMwRNdYLJvXYmcPWy
	sqMSuRI7g7qtFBKTcppMf6VRDrrqJ0Nfl5g==
X-ME-Sender: <xms:5r2rahj9IX07lbovPhL-2ZAkpUu9XUb2QU0MPPidDq-Wx9m0kZq65A>
    <xme:5r2rat5dpw39ubrfo99NJiUkWE8XoikXi50mJBcq-7s34ou8QlZhXxGKcp6PUtk4k
    82UVer1TXHSTl5uWcuti8Shd_bk3gXfjUMEFtMmq8UbIXCcaw>
X-ME-Received: <xmr:5r2ragfL8-6NyHg7R67OM_7puwW1-53JUR86QZPVqr61Wq0702xWIsBaCWuZ>
X-ME-Proxy-Cause: dmFkZTElf4d9n0/4S/7erGlusUKPYD2kcVG5VSpPnMvugy8VHPs94woHQ2rDfdtc1W9CwX
    86FQo3pMi+DM8URjsuP5zWzCro9JAStCkPeHMDE/0XdgZ93n4F1PyGbe3Ys/dT0yEiBfCI
    qCs2lW49Cm1MknQpsQrE1PDxUQFN7l4czIBZxB6hBWvSvFiUYYW2AdogLgRr+YIjbRBrbX
    ohX6aNml5uv0pjkLMgUL8xQurH6dnBRo6PJ1EkQ0wfcO5khEsZab6TRwXeYrBbT1O8nwLH
    9mGenjPgbYeFzd7aetRINFN0x0a282VDN4Hz5MJ/jdU86bzOLv4GWRMesmPHThnd+OfHk1
    CQ4D5xtJwjOGLqERDUdbBVUFkOBoudTQBzZZDYdg9HGgKEgmIC2XCTEnR1M32Xjkv7QRdE
    vQGT2q19PH9NSUNRnOIxyAwmrIoZF3kRaKGZcwHqW0zQjIOXxufVou3c3EXfwXVaX0p381
    /RLD7vnbhtJ+7T8L/amAH14uZdZEDme/8lAS1QWp7UrHkOwYANFwRLPEKne25Fv9FuCZh0
    I3BcqokUG41SMKEd6DGMspCMgnfI8K1CvXhLVuwbPbUzjJoUwFk2EA5VdjivN0xzcx5eSU
    BUEmkKhu2wMQD4u4OgpTR1vG/uwQ53i13H/2u+OBMtvuEKq+KaipGqi8/YoA
X-ME-Proxy: <xmx:5r2rauBD-xYS0Cm8oBMc8MQOY7MmEbQsdfcM8T8i7bSE0_rei0tAEg>
    <xmx:5r2ranBk_TnsUy51hVA1_f1-ynHJr3RqidhDv0pzVTZN1JpgGqQ7sA>
    <xmx:5r2raoZ_XIab4sASeyRKkh4v3g4oljwzjQ6hVyRMc58C9C4prd8vHg>
    <xmx:5r2rasz74uQamAnVkDUYU8o7_IWwiNCs0uvSk1Ow1Q80w5SReeWIdQ>
    <xmx:572rasEkbzNWQY6TfWX7r3UWd9bQ0MR3d4HoH1kNE6AoCNI5StNsDBms>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 06:16:06 -0400 (EDT)
Date: Thu, 17 Sep 2026 11:11:44 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>
Subject: Re: [PATCH 6.18.y 2/2] smb: client: honor forceuid/forcegid when
 mapping SIDs to uid/gid
Message-ID: <2026091740-corner-pantry-5439@gregkh>
References: <2026091604-dehydrate-dribble-9957@gregkh>
 <20260917042310.31062-1-sashal@kernel.org>
 <20260917042310.31062-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917042310.31062-2-sashal@kernel.org>

On Thu, Sep 17, 2026 at 12:23:10AM -0400, Sasha Levin wrote:
> From: Paulo Alcantara <pc@manguebit.org>
> 
> [ Upstream commit 18a72975e9f35aadecc75b031f693f2d1f49308f ]
> 
> When the administrator mounts with forceuid or forcegid (uid=/gid=
> mount options), they expect all files to appear owned by the specified
> user/group.  However, several code paths unconditionally called
> sid_to_id() to overwrite cf_uid/cf_gid with server-provided values,
> ignoring the administrator's explicit override:
> 
>   - smb311_posix_info_to_fattr() (stat via POSIX extensions)
>   - cifs_posix_to_fattr() (readdir via POSIX extensions)
>   - parse_sec_desc() (CIFS ACL ownership mapping)
> 
> This allowed an untrusted server to dictate local file ownership even
> when the mount was configured to force specific uid/gid values.
> 
> Fix all three call sites to check CIFS_MOUNT_OVERR_UID and
> CIFS_MOUNT_OVERR_GID before calling sid_to_id(), following the
> same pattern already used by cifs_unix_basic_to_fattr() for unix
> extensions.
> 
> Closes: https://sashiko.dev/#/patchset/20260906155816.603278-1-pc%40manguebit.org
> Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Paulo Alcantara <pc@manguebit.org>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Shyam Prasad N <sprasad@microsoft.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Bharath SM <bharathsm@microsoft.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/smb/client/cifsacl.c | 29 ++++++++++++++++++-----------
>  fs/smb/client/inode.c   |  9 +++++++--
>  fs/smb/client/readdir.c |  9 +++++++--
>  3 files changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
> index 11268d10a70ed..c66bbd5606a16 100644
> --- a/fs/smb/client/cifsacl.c
> +++ b/fs/smb/client/cifsacl.c
> @@ -1299,6 +1299,7 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
>  {
>  	int rc = 0;
>  	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
> +	unsigned int sbflags = cifs_sb_flags(cifs_sb);
>  	struct smb_acl *dacl_ptr; /* no need for SACL ptr */
>  	char *end_of_acl;
>  	__u32 dacloffset, osidoffset, gsidoffset;
> @@ -1317,17 +1318,21 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
>  	cifs_dbg(NOISY, "revision %d type 0x%x ooffset 0x%x goffset 0x%x sacloffset 0x%x dacloffset 0x%x\n",
>  		 pntsd->revision, pntsd->type, osidoffset, gsidoffset,
>  		 le32_to_cpu(pntsd->sacloffset), dacloffset);
> -/*	cifs_dump_mem("owner_sid: ", owner_sid_ptr, 64); */
> +	fattr->cf_uid = cifs_sb->ctx->linux_uid;
> +	fattr->cf_gid = cifs_sb->ctx->linux_gid;
> +
>  	rc = sid_from_sd(pntsd, acl_len, osidoffset, &owner_sid_ptr);
>  	if (rc) {
>  		cifs_dbg(FYI, "%s: Error %d parsing Owner SID\n", __func__, rc);
>  		return rc;
>  	}
> -	rc = sid_to_id(cifs_sb, owner_sid_ptr, fattr, SIDOWNER);
> -	if (rc) {
> -		cifs_dbg(FYI, "%s: Error %d mapping Owner SID to uid\n",
> -			 __func__, rc);
> -		return rc;
> +	if (!(sbflags & CIFS_MOUNT_OVERR_UID)) {
> +		rc = sid_to_id(cifs_sb, owner_sid_ptr, fattr, SIDOWNER);
> +		if (rc) {
> +			cifs_dbg(FYI, "%s: Error %d mapping Owner SID to uid\n",
> +				 __func__, rc);
> +			return rc;
> +		}
>  	}
>  
>  	rc = sid_from_sd(pntsd, acl_len, gsidoffset, &group_sid_ptr);
> @@ -1336,11 +1341,13 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
>  			 __func__, rc);
>  		return rc;
>  	}
> -	rc = sid_to_id(cifs_sb, group_sid_ptr, fattr, SIDGROUP);
> -	if (rc) {
> -		cifs_dbg(FYI, "%s: Error %d mapping Group SID to gid\n",
> -			 __func__, rc);
> -		return rc;
> +	if (!(sbflags & CIFS_MOUNT_OVERR_GID)) {
> +		rc = sid_to_id(cifs_sb, group_sid_ptr, fattr, SIDGROUP);
> +		if (rc) {
> +			cifs_dbg(FYI, "%s: Error %d mapping Group SID to gid\n",
> +				 __func__, rc);
> +			return rc;
> +		}
>  	}
>  
>  	if (dacloffset) {
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index f23c36d6ae6b3..f2adac6df7b24 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -847,6 +847,7 @@ static void smb311_posix_info_to_fattr(struct cifs_fattr *fattr,
>  	struct smb311_posix_qinfo *info = &data->posix_fi;
>  	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
>  	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
> +	unsigned int sbflags = cifs_sb_flags(cifs_sb);
>  
>  	memset(fattr, 0, sizeof(*fattr));
>  
> @@ -891,8 +892,12 @@ static void smb311_posix_info_to_fattr(struct cifs_fattr *fattr,
>  		fattr->cf_symlink_target = data->symlink_target;
>  		data->symlink_target = NULL;
>  	}
> -	sid_to_id(cifs_sb, &data->posix_owner, fattr, SIDOWNER);
> -	sid_to_id(cifs_sb, &data->posix_group, fattr, SIDGROUP);
> +	fattr->cf_uid = cifs_sb->ctx->linux_uid;
> +	fattr->cf_gid = cifs_sb->ctx->linux_gid;
> +	if (!(sbflags & CIFS_MOUNT_OVERR_UID))
> +		sid_to_id(cifs_sb, &data->posix_owner, fattr, SIDOWNER);
> +	if (!(sbflags & CIFS_MOUNT_OVERR_GID))
> +		sid_to_id(cifs_sb, &data->posix_group, fattr, SIDGROUP);
>  
>  	cifs_dbg(FYI, "POSIX query info: mode 0x%x uniqueid 0x%llx nlink %d\n",
>  		fattr->cf_mode, fattr->cf_uniqueid, fattr->cf_nlink);
> diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
> index f0ce26622a140..93135be123316 100644
> --- a/fs/smb/client/readdir.c
> +++ b/fs/smb/client/readdir.c
> @@ -242,6 +242,7 @@ static void
>  cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
>  		    struct cifs_sb_info *cifs_sb)
>  {
> +	unsigned int sbflags = cifs_sb_flags(cifs_sb);
>  	struct smb2_posix_info_parsed parsed;
>  
>  	posix_info_parse(info, NULL, &parsed);
> @@ -281,8 +282,12 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
>  		 le32_to_cpu(info->ReparseTag),
>  		 le32_to_cpu(info->Mode));
>  
> -	sid_to_id(cifs_sb, &parsed.owner, fattr, SIDOWNER);
> -	sid_to_id(cifs_sb, &parsed.group, fattr, SIDGROUP);
> +	fattr->cf_uid = cifs_sb->ctx->linux_uid;
> +	fattr->cf_gid = cifs_sb->ctx->linux_gid;
> +	if (!(sbflags & CIFS_MOUNT_OVERR_UID))
> +		sid_to_id(cifs_sb, &parsed.owner, fattr, SIDOWNER);
> +	if (!(sbflags & CIFS_MOUNT_OVERR_GID))
> +		sid_to_id(cifs_sb, &parsed.group, fattr, SIDGROUP);
>  }
>  
>  static void __dir_info_to_fattr(struct cifs_fattr *fattr, const void *info)
> -- 
> 2.53.0
> 
> 

Does not apply :(
