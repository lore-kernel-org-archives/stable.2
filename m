Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0BE54CF42
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959363; cv=none; b=nAm9Lyo3ztO+Rqkc8HE2d4xlKoQXPTpl5JFRAyf4g7vWWRCxrsRNs9TTRzd3njbspo2c5Lk156OLLeuGqW+JwODOdiwMEcdA3C06cRls1BnPOsIk5iAur5jHkUla+cTt/65NTvB3LKm7sTCRf58THM6PQnNgVTyUZncn1v74cTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959363; c=relaxed/simple;
	bh=0BMlJDQxE8dKXEHbMBf3wqQKIARf3jVdy0yO0AujxHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei4PJEjCuJagC4jdoEGOwAQA2wlHGGf3OFe1qc/Ath+ZTosEe6FJ6ckRee5w+aEtlD8/oedkfF/ZvlI8rm+uFHt1t17b56qedDbo5SGbUK6w31aofGXFIWVNCj7HZXee6q8sYp14LOvUZSy8y4Ic7dcBPgsSfW5fe6tg5a+Je9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=hZdSZHTE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=elEBXIcS; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="hZdSZHTE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="elEBXIcS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8EDC01400053;
	Wed,  9 Sep 2026 09:09:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 09:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788959360; x=1789045760; bh=hUKVtd273N
	MpuSIEsCwQb7Zs1MumDZiNdDi/RgmXYgc=; b=hZdSZHTEpd725Qnm/JXABViwmY
	aNxzUDT628BjGUgfKbWetrjG3TJAYDorJhLqX2fsqFFShvBjk0q5vNf2jfUBLB7+
	vB/AvzSOFNhzhC4Rh1Cs38ZOtp9i5PQY99dtAxEBoXMsGatezDQ9pqOjFTcrRUze
	v1NyA8PfHPUAbpwTt1SR+mq/lhPX+jLYTcHS4o3KKjQdd8usjzF15OPi8HMWSZWA
	fEVnRRdisTfklsqhFNU8QR0x1PrqTRxi8F5Tskv86IynbAtQ6E+MhY8/ChFGFkrL
	WdvJ2tPDQezEPrqx53z+acMbCmrDW5DNbdq506zi6FQ6M72rnNA4fEE4NXPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788959360; x=1789045760; bh=hUKVtd273NMpuSIEsCwQb7Zs1MumDZiNdDi
	/RgmXYgc=; b=elEBXIcSj8dQuvCzf0H4G1WmAY5RDGckBxE5ia7rv/7zwFkZImh
	rCSqCbtEMtVW9PYEdUvBa36ej8iwviMN/2xdJ+sgTt2S7uU0tMRocDWr6gLKzRke
	rZdBLgv1lYb0rCa3kXr/i7fzWuWaLy7FymXkiIrbsydZCOdevzqc3H55GpdcKjik
	jaYKE2AIIc81NEDB7WiJMQBn1IqBD7fz+O/wYgNvwUwLESAqf97e9vAt9i8w6AQM
	8o5MB0M4dxAEOseAG7y1Y5jvbHoOqEfe2fEWDVcVsMWs3xpimB3mGi91FRpkuyOr
	L0kAQ0XlTmTZq0SlRO919cO79xD/VIYlj5g==
X-ME-Sender: <xms:gFqhatTcex9KP2zHeR3BUsP6RGerPIPddlGcRSwxy1cgA8OCWAHvuA>
    <xme:gFqhagHugP8CnRPAZPccUsy-NDTwFe5pSaneGYkGr-GTsOOBgHNopIB6h1K23-Sj5
    dFygQnOTLw4M7lLXRRS8KCmnzWAG8Lyf47nYuDDCHubqety6EE>
X-ME-Received: <xmr:gFqhaqELHE1TbBDJeUS_Dt3reDw7imDzZH7bJ6gjn1TTdy-gUiSTAUPeYM6DKtkqY-HReJjF_sd9IRvd9OmWdZLAiaYbf_sbG_4wUABFuzQ>
X-ME-Proxy-Cause: dmFkZTGvZ5OvdXI/2ZW8HsdJZ6BRpytu7mvIbIeApq578K893caYjBKow/Rn/v4/4nH4z0
    gb/tKDkgV+nJ8COugJyvYYEqtqRzDaLzAMlAOaFdZ1fFGLS6vVVLB7PUlzMsx4ePpOBbSB
    XD1Advv4xffPRYexh89kw0g4Inmi+JxoHrQ6HtFXzWcD7GHpNcsw1eAk7fMDMH+ZgJ9Yap
    9xSKlpcBXWRD+KTX1cmpr1iW+J9qlcO1nM1sno6SNIPclsMGVG+SCtGFLg1dq2dbFkUF3y
    33dC9X7YJOte0owitN0Y0cWol739M+RIB7PEYgzzWxLXhfvaAP+9iD9AllI/MKSoZu8nkj
    D/y6oSH+Z+zCylP5UoY6YZWOy8RmfaLpLVyLOBVhSPUtd/56JIibqNr4IqdxyVVHROQk+X
    zgqGr6wI9sYx5NsHZUubwbBONJNUbae0nnDDyg07VodGpYV81/petvBdI0mC1nsmT/K69G
    k3LlIbwaZY8ynjrn6uoajKMpsiCSO2Hu0aI+4rf1bykeraGyMRXwOIm4xoGsD2fBXrh0Tb
    rNgKIk0B/i1289poWslcd7NwnHyEvyKt8aYRr6Ja4y+HuOxxmJDYEA1x1OWSQx8JHyyyZV
    dH+0U5xwVxWbx5n6gTks43TCbLW1Vh8WW8x/e1VsEr942x7RlqilW9OKlCWw
X-ME-Proxy: <xmx:gFqhamS4_-zTPNBNsglNUlIPvUdh--mK9OcwPbbx4mnXpzRyr0QmEw>
    <xmx:gFqhajLRw2q0q52QERz3FEPFMPZElDz10-ve25zRPOq4N7rliNzOPg>
    <xmx:gFqhapYCOZgSZXwM41W8PctfQcbs_FfvrFxDvFLjtIHv4EkhfYk3Bw>
    <xmx:gFqhat-5JGqZmbLNGN3Ml_yKIj-8ZC2_1NCylJl0y9ImNBti6FVBuQ>
    <xmx:gFqhamou6yQEILsNF6a8_uZGiehKAsFxEsLENpp-gAKEbdpFbnNvNLmy>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 09:09:19 -0400 (EDT)
Date: Wed, 9 Sep 2026 15:08:11 +0200
From: Greg KH <greg@kroah.com>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: stable@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH 7.1.y] ksmbd: fix use-after-free in oplock break
 notification
Message-ID: <2026090901-nature-subsidize-3334@gregkh>
References: <20260909075835.3286-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909075835.3286-1-suruurism@gmail.com>

On Wed, Sep 09, 2026 at 10:58:35AM +0300, Abdifatah Suruur wrote:
> smb2_oplock_break_noti() reads opinfo->conn without any lock and
> dereferences it after two allocations which may sleep.  When the
> durable handle owning the oplock is disconnected, session_fd_check()
> clears opinfo->conn and drops its conn reference under ci->m_lock, and
> the last ksmbd_conn_put() frees the connection.  A break triggered by
> another connection that races with the teardown can then resurrect the
> freed connection: ksmbd_conn_get() is a plain atomic_inc, and the
> queued break work later dereferences the stale conn via
> ksmbd_conn_write(), a use-after-free reachable by any authenticated
> client holding a durable batch oplock.
> 
> Thread the caller's inode into the notification path instead of taking
> a new reference on it.  Every caller of oplock_break() already holds a
> live ksmbd_file (or an explicit ksmbd_inode_lookup_lock() reference,
> in the parent lease break paths) on the inode that owns the break
> target's oplock list, so ci cannot be freed during the call, and its
> lock can be taken without dereferencing opinfo->o_fp, which a
> concurrent close may free.  Select and pin the connection under
> ci->m_lock, the same lock session_fd_check() and
> ksmbd_reopen_durable_fd() use to update opinfo->conn, so a concurrent
> detach either loses the race to the clear or keeps the connection
> alive until the notification work releases it.  Transfer the reference
> to the work item and release it on allocation failures.
> 
> [ This tree predates the deferred break machinery
>   (oplock_break_add()/oplock_break_drain_none()) that the original
>   commit is layered on; oplock_break() here calls the notifier
>   directly and the caller-pinning argument is unchanged. ]
> 
> Fixes: b003086d7696 ("ksmbd: fix NULL-deref of opinfo->conn in oplock/lease break notifiers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> commit 0e753899627b5e28a9fea8bca98262a6f65a2452 upstream.
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> ---
>  fs/smb/server/oplock.c | 61 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 49 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
> index 3f28dc3b7fc41..b8bc0d16e042c 100644
> --- a/fs/smb/server/oplock.c
> +++ b/fs/smb/server/oplock.c
> @@ -708,31 +708,67 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
>  	ksmbd_conn_put(conn);
>  }
>  
> +/*
> + * Select and pin the connection used for an oplock break before doing any
> + * allocations which may sleep.  The caller of oplock_break() holds a live
> + * reference on ci (a file being opened, a file being operated on, or an
> + * explicit ksmbd_inode_lookup_lock() reference in the parent lease break
> + * paths), so the inode cannot be freed during the call.
> + *
> + * opinfo->conn is cleared under ci->m_lock by session_fd_check() when the
> + * durable handle owning the oplock is disconnected, reassigned by
> + * ksmbd_reopen_durable_fd() under the same lock, and the last
> + * ksmbd_conn_put() of the old connection frees it.  Holding the read lock
> + * excludes both writers, so the connection cannot be freed while it is
> + * selected.
> + */
> +static struct ksmbd_conn *smb2_oplock_break_conn_get(struct oplock_info *opinfo,
> +						     struct ksmbd_inode *ci)
> +{
> +	struct ksmbd_conn *conn;
> +
> +	down_read(&ci->m_lock);
> +	conn = READ_ONCE(opinfo->conn);
> +	if (conn && !ksmbd_conn_releasing(conn))
> +		conn = ksmbd_conn_get(conn);
> +	else
> +		conn = NULL;
> +	up_read(&ci->m_lock);
> +
> +	return conn;
> +}
> +
>  /**
>   * smb2_oplock_break_noti() - send smb2 exclusive/batch to level2 oplock
>   *		break command from server to client
>   * @opinfo:		oplock info object
> + * @ci:		inode owning the break target's oplock list, pinned by
> + *		the caller
>   *
>   * Return:      0 on success, otherwise error
>   */
> -static int smb2_oplock_break_noti(struct oplock_info *opinfo)
> +static int smb2_oplock_break_noti(struct oplock_info *opinfo,
> +				  struct ksmbd_inode *ci)
>  {
>  	struct ksmbd_conn *conn;
>  	struct oplock_break_info *br_info;
>  	int ret = 0;
>  	struct ksmbd_work *work;
>  
> -	conn = READ_ONCE(opinfo->conn);
> +	conn = smb2_oplock_break_conn_get(opinfo, ci);
>  	if (!conn)
>  		return 0;
>  
>  	work = ksmbd_alloc_work_struct();
> -	if (!work)
> +	if (!work) {
> +		ksmbd_conn_put(conn);
>  		return -ENOMEM;
> +	}
>  
>  	br_info = kmalloc_obj(struct oplock_break_info, KSMBD_DEFAULT_GFP);
>  	if (!br_info) {
>  		ksmbd_free_work_struct(work);
> +		ksmbd_conn_put(conn);
>  		return -ENOMEM;
>  	}
>  
> @@ -741,7 +777,8 @@ static int smb2_oplock_break_noti(struct oplock_info *opinfo)
>  	br_info->open_trunc = opinfo->open_trunc;
>  
>  	work->request_buf = (char *)br_info;
> -	work->conn = ksmbd_conn_get(conn);
> +	/* Transfer the reference acquired by smb2_oplock_break_conn_get(). */
> +	work->conn = conn;
>  	work->sess = opinfo->sess;
>  
>  	ksmbd_conn_r_count_inc(conn);
> @@ -890,8 +927,8 @@ static void wait_lease_breaking(struct oplock_info *opinfo)
>  	}
>  }
>  
> -static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level,
> -			struct ksmbd_work *in_work)
> +static int oplock_break(struct oplock_info *brk_opinfo, struct ksmbd_inode *ci,
> +			int req_op_level, struct ksmbd_work *in_work)
>  {
>  	int err = 0;
>  
> @@ -957,7 +994,7 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level,
>  	if (brk_opinfo->is_lease)
>  		err = smb2_lease_break_noti(brk_opinfo);
>  	else
> -		err = smb2_oplock_break_noti(brk_opinfo);
> +		err = smb2_oplock_break_noti(brk_opinfo, ci);
>  
>  	ksmbd_debug(OPLOCK, "oplock granted = %d\n", brk_opinfo->level);
>  	if (brk_opinfo->op_state == OPLOCK_CLOSING)
> @@ -1137,7 +1174,7 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
>  				continue;
>  			}
>  
> -			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE, NULL);
> +			oplock_break(opinfo, p_ci, SMB2_OPLOCK_LEVEL_NONE, NULL);
>  			opinfo_put(opinfo);
>  		}
>  	}
> @@ -1178,7 +1215,7 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
>  				continue;
>  			}
>  
> -			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE, NULL);
> +			oplock_break(opinfo, p_ci, SMB2_OPLOCK_LEVEL_NONE, NULL);
>  			opinfo_put(opinfo);
>  		}
>  	}
> @@ -1280,7 +1317,7 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
>  		goto op_break_not_needed;
>  	}
>  
> -	err = oplock_break(prev_opinfo, SMB2_OPLOCK_LEVEL_II, work);
> +	err = oplock_break(prev_opinfo, fp->f_ci, SMB2_OPLOCK_LEVEL_II, work);
>  	opinfo_put(prev_opinfo);
>  	if (err == -ENOENT)
>  		goto set_lev;
> @@ -1366,7 +1403,7 @@ static void smb_break_all_write_oplock(struct ksmbd_work *work,
>  	}
>  
>  	brk_opinfo->open_trunc = is_trunc;
> -	oplock_break(brk_opinfo, SMB2_OPLOCK_LEVEL_II, work);
> +	oplock_break(brk_opinfo, fp->f_ci, SMB2_OPLOCK_LEVEL_II, work);
>  	opinfo_put(brk_opinfo);
>  }
>  
> @@ -1430,7 +1467,7 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
>  			    SMB2_LEASE_KEY_SIZE))
>  			goto next;
>  		brk_op->open_trunc = is_trunc;
> -		oplock_break(brk_op, SMB2_OPLOCK_LEVEL_NONE, NULL);
> +		oplock_break(brk_op, ci, SMB2_OPLOCK_LEVEL_NONE, NULL);
>  next:
>  		opinfo_put(brk_op);
>  	}
> -- 
> 2.53.0
> 
> 

7.1.y is long end-of-life, sorry.
