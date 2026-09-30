Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33F329391
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774481; cv=none; b=BxuRZ2gs0xdCzbJFW9MdqgaPCH/wI49X0ar++Y/zMsweFou9KQ/yZpYKXHjEmTRbQCv+Vwdys2OjDOjnNSkxVXyd9rx60mhmCa00drBaRqvsIgW2C4Elxc4h3p7oEwFdVxDDiw83yugHm5R0sLF8RSydj7RvVeBk2PlpoHb0cY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774481; c=relaxed/simple;
	bh=6zkmbP5vAFh0bgJ0QO4MvuBoHJcQ+b6AuxOLSJ8+vZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8LqS2xMFTP5EbLWjuKXy9POjTJ/efHJN+DKwaF5WfWLUPy8VSarpno1iz/pydssYHHBQkZ61ZCasLbXGhMHL8QiopjvNY6mzjDjUU0lJPtRD59tt+3HxC/QpKkAEsinQNVBZNiv3foGbgSG5jsHbvXzGAP5qLo9ZxZrKwPNwoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=G9XZI6C8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ndrh+9x5; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="G9XZI6C8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ndrh+9x5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 326AB1D006C8;
	Wed, 30 Sep 2026 09:21:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 30 Sep 2026 09:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790774465; x=1790860865; bh=sXaqN8gzlz
	sdDBfumD0SlxjIPEM5MoXHXBHme4xwZYQ=; b=G9XZI6C8203coYzu2zJcA95h+t
	NOSO2iY/ytVOB5dL67qzTyhjQ31LuLHxAFSO/PWFPDT6KA3BV6Y8EwoNX5xGl8nO
	3rF2TzNcqToiG37p+tRfKpRvOjcceXopm2wgFsP/BwKai6QJUKFg09E4uV7hJHkw
	4sgmLwAFNbLod4caQChZEb0lUQgn4k4tuXjna2oeQy1VHSNKWldngo1CR2lE1kyh
	BfycVzMLMD0bfQvinGpPtElxUwntA57TRJrL8Wn1kw7QQgAfyABJPs2yLDweD+8k
	iJ6GBWaBvcnJpKrMM8I0WQp4Ad8NWpqg7MW3Uf4lU2BUFJ27QiKVU/6hzNNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790774465; x=1790860865; bh=sXaqN8gzlzsdDBfumD0SlxjIPEM5MoXHXBH
	me4xwZYQ=; b=Ndrh+9x5rnvdPBu5mkbQQnL7SKaQQc2Iappmp7MI8VFESIswUpI
	UJF1K5il7pUHCmFblCQFDNtw9xGithfC23+pviv7525ZHawwcasVAEhzWeckqWeX
	uLrECsDRzKmojNmogbi+vtucFZRzLxh2jPKSy8L3WiJinDcly/MeXmJEk0H2IihZ
	6qnC/n1twREXTl1FHOPmwpO82fmAugLgavOBJSrCFKLu+KWj3dCiF5qaaQ4l8DIw
	xhNxv74VZYjzY3JnEmyu3RBMF7ihPvFVYuAgvMoVtBs00okb7vZeyZoUJEiG4cJN
	LPkVCZsRd5FAUsqOrKNlHslcEaky9ieRtIA==
X-ME-Sender: <xms:wAy9athOtMRIM5WdMucBN3vAyE8ObyApEKRtDxeelp9xsN9WenV9HA>
    <xme:wAy9alGjMO-0OZFL-HeaNDzGg8tPvRdImeBaCMMoXbsg4aIRn6soxneJQgpwTwHOn
    fkUcuQPu5BSJuw5byJ6jm629jIV-7z3x9QxUW1Xh5SohDk1Xg>
X-ME-Received: <xmr:wAy9ansnOrNhMr4XraEtG69kE3khyZfoQI-2pRvjv0dLCu_TixAcwVCY8w1Q3Iu_9yVfHPO-4qIYY5xCwIcYOA-a9J8Z1XZ7RqDVamyY8Ks>
X-ME-Proxy-Cause: dmFkZTGKLk5OqqOT/HiVSR/OQlFqYHDwtF03gvROP4n5lI4H3D4aiL9rwinpFdqg9AUT8q
    rcyAL/amPIn0Kc2NN5cg11gqEVmT4v3kC4gPYfxc7m0DW+nbegO0vhZERILAwCKksReDBz
    mh01w41kZoUWd6dPPVfGxSSLSxp2MFgfQt0BuGYPCDnjLb68mDdPjUwJbADqOupnNrgM9W
    SMHFd0clnE4G0rE8GSUeezCkLZcnS/lS9KWopn7GwMcMHXnu9l7X6K87kaICQdcAsG4sRp
    X8GgAIBWpakpBrCbScUg2KyWncExUSY+xZlRaK00oDjTgs1xpdG+DSz5UEX6SJYsFxWBaX
    lSeicO8bZnuWPz7naFI5YdHIbaene1F1zQYSqaBNxfJXd2583ac0GsySRgn17EWysfLtsq
    f23c9+kHur1ebZ54GbPYgD57mkJvFeaVar/p7fwrAtn6uBBfJBUl2UAUw6YgYoDLfFqGUm
    ZnvOMTxqZmxTZjPaQaG3zidJ4+mm5KgVT1kn4obJLTm+G8C+ZAJnXE/rCOI9rg44qAjQd+
    6FHfvC7q0/jbp9cKaFw91mmLaeJDdLchRtK1zlr+fPK6J+z3oUX++xTj+AYsul2MfKqQuA
    XUNsW4A2ENUlMhl5D/rC4vX/u+RwH7ZGM87+7ihnfA5M9C7A+4L5hs2Vs5Dw
X-ME-Proxy: <xmx:wAy9aufIoXdqv1ew48cku7U0lEhzFkOowTBjvt8N-Rp9FHyMBdUxCA>
    <xmx:wAy9all9FmU-GnE52oShn7rY75S_EO66aZs-66eZz0XmTZ3SmO4fpw>
    <xmx:wAy9apBlr70TUouLK4IO1Ntbrdod8WTzQQlcWIMIcZEIA2N2C6T_wQ>
    <xmx:wAy9anNgKGM2k8kwCoJou9b-oGnaAKODFQG1dtK2HEAaHck_E8nLCQ>
    <xmx:wQy9amH5F-BC01xaB9APpU1X62nNgGqEtP0ZKyY814CnZBPhlAYYknBb>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:21:04 -0400 (EDT)
Date: Wed, 30 Sep 2026 15:20:59 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
	Kanishka De Silva <kpskanna1915@gmail.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>
Subject: Re: [PATCH 6.12.y 2/2] ksmbd: prevent out-of-bounds reads in share
 config responses
Message-ID: <2026093055-rink-mace-ba4c@gregkh>
References: <2026091411-perish-luster-7e07@gregkh>
 <20260914141551.61407-1-sashal@kernel.org>
 <20260914141551.61407-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914141551.61407-2-sashal@kernel.org>

On Mon, Sep 14, 2026 at 10:15:51AM -0400, Sasha Levin wrote:
> From: Namjae Jeon <linkinjeon@kernel.org>
> 
> [ Upstream commit f25e93768fcc5d8287e50b1ec52a42e4c276df34 ]
> 
> Validate IPC share configuration payload sizes before consuming
> variable-length fields. Bound veto list parsing and account for
> the separator byte when deriving the path length.
> 
> Fixes: a677ebd8ca2f ("ksmbd: validate payload size in ipc response")
> Reported-by: Kanishka De Silva <kpskanna1915@gmail.com>
> Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/smb/server/mgmt/share_config.c | 40 +++++++++++++++++++++----------
>  fs/smb/server/transport_ipc.c     | 21 ++++++++++------
>  2 files changed, 41 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
> index 97b0bbd619979..e34e86cce0fc3 100644
> --- a/fs/smb/server/mgmt/share_config.c
> +++ b/fs/smb/server/mgmt/share_config.c
> @@ -88,9 +88,9 @@ static struct ksmbd_share_config *__share_lookup(const char *name)
>  
>  static int parse_veto_list(struct ksmbd_share_config *share,
>  			   char *veto_list,
> -			   int veto_list_sz)
> +			   size_t veto_list_sz)
>  {
> -	int sz = 0;
> +	size_t sz;
>  
>  	if (!veto_list_sz)
>  		return 0;
> @@ -98,7 +98,7 @@ static int parse_veto_list(struct ksmbd_share_config *share,
>  	while (veto_list_sz > 0) {
>  		struct ksmbd_veto_pattern *p;
>  
> -		sz = strlen(veto_list);
> +		sz = strnlen(veto_list, veto_list_sz);
>  		if (!sz)
>  			break;
>  
> @@ -106,7 +106,7 @@ static int parse_veto_list(struct ksmbd_share_config *share,
>  		if (!p)
>  			return -ENOMEM;
>  
> -		p->pattern = kstrdup(veto_list, KSMBD_DEFAULT_GFP);
> +		p->pattern = kstrndup(veto_list, sz, KSMBD_DEFAULT_GFP);
>  		if (!p->pattern) {
>  			kfree(p);
>  			return -ENOMEM;
> @@ -114,6 +114,9 @@ static int parse_veto_list(struct ksmbd_share_config *share,
>  
>  		list_add(&p->list, &share->veto_list);
>  
> +		if (sz == veto_list_sz)
> +			break;
> +
>  		veto_list += sz + 1;
>  		veto_list_sz -= (sz + 1);
>  	}
> @@ -165,17 +168,28 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
>  	}
>  
>  	if (!test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
> -		int path_len = PATH_MAX;
> -
> -		if (resp->payload_sz)
> -			path_len = resp->payload_sz - resp->veto_list_sz;
> +		size_t path_len;
>  
> -		share->path = kstrndup(ksmbd_share_config_path(resp), path_len,
> -				      KSMBD_DEFAULT_GFP);
> -		if (!share->path) {
> -			ret = -ENOMEM;
> +		if (resp->payload_sz <= resp->veto_list_sz) {
> +			ret = -EINVAL;
>  		} else {
> -			ret = 0;
> +			path_len = resp->payload_sz - resp->veto_list_sz;
> +			if (resp->veto_list_sz)
> +				path_len--;
> +
> +			if (!path_len) {
> +				ret = -EINVAL;
> +			} else {
> +				share->path = kstrndup(
> +					ksmbd_share_config_path(resp),
> +					path_len, KSMBD_DEFAULT_GFP);
> +				if (!share->path)
> +					ret = -ENOMEM;
> +				else
> +					ret = 0;
> +			}
> +		}
> +		if (share->path) {
>  			share->path_sz = strlen(share->path);
>  			while (share->path_sz > 1 &&
>  			       share->path[share->path_sz - 1] == '/')
> diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
> index a0b9b3def3346..10847d1cda4ac 100644
> --- a/fs/smb/server/transport_ipc.c
> +++ b/fs/smb/server/transport_ipc.c
> @@ -524,14 +524,21 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
>  		if (entry->msg_sz < sizeof(struct ksmbd_share_config_response))
>  			return -EINVAL;
>  
> -		if (resp->payload_sz) {
> -			if (resp->payload_sz < resp->veto_list_sz)
> -				return -EINVAL;
> +		if (strnlen(resp->share_name, sizeof(resp->share_name)) ==
> +		    sizeof(resp->share_name))
> +			return -EINVAL;
>  
> -			if (check_add_overflow(sizeof(struct ksmbd_share_config_response),
> -					       resp->payload_sz, &msg_sz))
> -				return -EINVAL;
> -		}
> +		if (resp->veto_list_sz > resp->payload_sz)
> +			return -EINVAL;
> +
> +		if (resp->flags != KSMBD_SHARE_FLAG_INVALID &&
> +		    !(resp->flags & KSMBD_SHARE_FLAG_PIPE) &&
> +		    resp->payload_sz <= resp->veto_list_sz)
> +			return -EINVAL;
> +
> +		if (check_add_overflow(sizeof(struct ksmbd_share_config_response),
> +				       resp->payload_sz, &msg_sz))
> +			return -EINVAL;
>  		break;
>  	}
>  	case KSMBD_EVENT_LOGIN_REQUEST_EXT:
> -- 
> 2.53.0
> 
> 

Series did not apply
