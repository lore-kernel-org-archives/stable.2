Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAC742AF87
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225157; cv=none; b=EEJS5iP4rOnX9Vn25Ig4mNwnbeYJCywh3LCAC7f2Brp1xnkbDm0Xl/h7Twd523VGRVFiI/y2dU287iY8uTENVVUhpX7nKWAi2P6pqqErWAhV8Wle32yfINWrISq7VpikfQes6rKQXg9x4OvabT4EHp4G4F4emIZHAXu1VnMWP90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225157; c=relaxed/simple;
	bh=pEeaGQ0Mdt1TA25PSLc7VPAWIjxPHlZzAjXBnPJKvTg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lel9JuvS72KZ0wA/TOqDW4H3fr0PZEv1DkX9bn4D/CdSBJrdvpydH6sqFNaOxykDafbg/PHHI2Xp/R+6WuYM0RFv62XbN2721MdIkYqdd0xiNcbstsBthn4gbHkW/ly3p1jLSgF0e+ygD86fNNzPVNOL2Dnsb/SV8x8mD9oskzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KagFmqzZ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KagFmqzZ"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K39ljl012149
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:25:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=Kr+K+zjOdEMK9wEKulfes8NAHCfzB3pGDnX9o
	xPQjJo=; b=KagFmqzZ951XX8MJF6VNCBjnks2ID1/DU+XapiW836v0LX372gJbr
	b1ixjExCDE6WSnT1a1jK4smxh22Y1/Ne8Pk0B3ZQf584hXCYYqoex27AkVPssae9
	VqLqRjjxPcU8bJnvBTkfEqvZvoIkEB5OOMuFCHVqWE9rnyuTbTnBb6TAQNk32jcj
	Z7G6hVl9fIAiJbtODijskdpUlVbE75pux+R7sLK0RaYGxxZ/eRHRR8BQ70XZBW1s
	dZCFKTkuij31TekhmRHStEm6/lZzp0Nwd6PmDajkqhIyAHmMb5UB+6Z6ux7cPekP
	hyygvMtl36VFutt1WNxZNcYcuV18SPHDA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g4yfncwek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:25:49 -0700 (PDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0e702df8so27900781cf.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787225148; x=1787829948;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kr+K+zjOdEMK9wEKulfes8NAHCfzB3pGDnX9oxPQjJo=;
        b=EvDvXKLSlaKjs5XGh6gfMoXcqGXFXW4Ib+AgaD3eknCAO64Q3/kBzIdqp285661dvS
         aDwZVfReXneju+CwA43pF56eAO8foICg8qo9BBdwP6p0uZ/pBhGkNPTagEM2Hppujma+
         0cF6rvGgVooJ3KavJS5TpIRgMzM+Ezi84FIyal4BE9VQg3clvCnmRHE1giZo5nHjKS8T
         Sxd99WadSG6rZKNNIbI9WuQCxzMJxn0HuCqwSzOlkOZj+IoDEQdZcYeeCnU4UUdadU1b
         lXkZF2Uz6Jl0kNoy6pdV8YKjgBMVZ15r2ANu8A+osoWMvnfzyDQNP9oymonAoVbCH+kw
         tsSg==
X-Forwarded-Encrypted: i=1; AHgh+RoN+k2FpzImu33cHmVtZdMux54QNHuU2AG4kYoBNvxSNovlDhuDcjHwKO0tP7c8WLP5DZmAS5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrBVgGcek7j9PMHaQ5F46Loy1qkREcSCfMDf+YiTt+uBraZb3+
	YoA4QmBOj1M6ClJBtl9EK84Yp1vHCxA5yk9c/gI/TLpaqY4qRvUOdohclPOwmz8dKjVPqslohuG
	G+RGPD8UAKHwTW/G8QRRJwlRydd0nolaLztAx/C8drlGmHmhOO2P/4fkQ
X-Gm-Gg: AR+sD126TJVk2g1HFAkNoPRWMtz8bioKTC30YidT+O79CmOos0P6wUnSdWeYDBsCbYh
	Re6f0DJ2gZwUpW+6m6CfJdSI47e6HJ/RTywjM7PCMPTlzF1gG2lU5xRK0QoEJU1RfkZADG9U8b9
	Ue0+cdHnclh0Q+MDvWX6Unsc678cMMgUqU6KXaGBispbLpOT1gHRa/IYx3bjJJPA3wtMCX5OkXp
	XubYk1SjHbEtYlw75xBsrKqycit5UMoS1NaK8ds89ALvaqCk/r7OjSkVCkYvDvZ1hzTOUMxDd7X
	FlZxWy0tY9Iq+RTTI/4YVWN4G5gB6MKACR5uhCIcqvc0sQ/fy6Ikb/A2KoINiCeFRzYoZ4O8UK8
	X
X-Received: by 2002:a05:622a:58cd:b0:51a:8696:cb38 with SMTP id d75a77b69052e-52dd57853damr115785121cf.7.1787225148459;
        Thu, 20 Aug 2026 04:25:48 -0700 (PDT)
X-Received: by 2002:a05:622a:58cd:b0:51a:8696:cb38 with SMTP id d75a77b69052e-52dd57853damr115784341cf.7.1787225147838;
        Thu, 20 Aug 2026 04:25:47 -0700 (PDT)
Received: from [192.168.77.173] ([68.20.15.154])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd872f61esm29031451cf.23.2026.08.20.04.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:25:47 -0700 (PDT)
Message-ID: <3a7777fb1f0678c88c2365a6a476167b5abc4e9d.camel@meta.com>
Subject: Re: [PATCH] btrfs: abort transaction before releasing
 tree_log_mutex on commit failure
From: "jlayton@meta.com" <jlayton@meta.com>
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Filipe Manana
	 <fdmanana@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 20 Aug 2026 07:25:46 -0400
In-Reply-To: <698c480ec13cd6e74c2175924f614b7e324e6cc3.1787099421.git.loemra.dev@gmail.com>
References: 
	<698c480ec13cd6e74c2175924f614b7e324e6cc3.1787099421.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA4NCBTYWx0ZWRfXz6DlXwRSCbpC
 sHTnXMs00My8JL0j7/FwFuGYdpuFV7PR/b6FXvzz0VeANMSoeJy5rEd9bFtGIaGgS38yBQXddq7
 GXiOGLqwtVY5EM7ouGxWH7+COWScZXwB8e0kYyKxkM3KUuhbx+FEq46l4wNHTR0BUyu0yR84k0M
 GexelAdZuB9GlDTgMk9MLGEhFs119f8jFXqB+jRHuSpUnuAOHK9/ohj6BuusgRp1YQqAnJOC83U
 9B0e60q21dYW3W+gxAjbIxzytsxxRsriVA2J5qRrEWQitTPNBNzmzzGadOeEuzUnwyMpRuaqdt9
 X1xZH3yeHdjsQzem9+39c2v2ibig/BZeVGV5xXkYlevzZzoThZE8NovFERPNM7auLltq4DAIyMR
 BaIBEMFhMNGI+JQO9LZsYS6CuknCDMNvwrKvbvUO4VrLmazIbw9ewNcZQtdmjQ90Vc0EbPqR742
 qxgZ0bnuo6hFHzOoRAw==
X-Proofpoint-GUID: 4_DKvQXmUl6Jpz3fMpkXN-8CR2pHNQwx
X-Proofpoint-ORIG-GUID: 4_DKvQXmUl6Jpz3fMpkXN-8CR2pHNQwx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA4NCBTYWx0ZWRfX1yMOhixhk0Ac
 xKDL+TTN8SY2v/O+1IMABWsnzFsjLWtmrMSAuisGIOdQQP1588OQD7piAx1SZDcbJyfdLbKvcNR
 p0sK9ht9G/6Qr9xDpLxNbTolwNWlbAI=
X-Authority-Analysis: v=2.4 cv=fOwJG5ae c=1 sm=1 tr=0 ts=6a86e43d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=I8GJ1mTG6nUeI1lZk6893w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=7j0FZ4iXMVMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8 a=5xnzj68laMxwpfVuNd8A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01

On Tue, 2026-08-18 at 17:40 -0700, Leo Martins wrote:
> When transaction metadata writeout fails in btrfs_commit_transaction(),
> the current code only logs the error, drops tree_log_mutex and then goes
> through cleanup_transaction(), which aborts the transaction and records
> the fs error.
>=20
> That is too late for the tree log side. A log sync can already be
> waiting on tree_log_mutex, because the committing transaction is moved
> to TRANS_STATE_UNBLOCKED while that mutex is held, which lets fsyncs
> join the next transaction and queue up in btrfs_sync_log(). Once the
> failed commit drops tree_log_mutex, such a log sync acquires it, sees
> BTRFS_FS_ERROR() still clear, and writes super_for_commit. That
> superblock holds the roots prepared for the transaction that has just
> failed to write out its metadata, so it can point at tree blocks that
> never reached the disk, and the next mount fails with a parent transid
> mismatch.
>=20
> Commit 165ea85f1483 ("btrfs: do not write supers if we have an fs
> error") fixed this class of problem by making btrfs_sync_log() check for
> an fs error right after taking tree_log_mutex. That check only works if
> the commit path publishes the fs error before it releases the same
> mutex, and commit 68d4ece9c30e ("btrfs: don't call
> btrfs_handle_fs_error() in btrfs_commit_transaction()") removed the only
> thing that did so.
>=20
> Restore the ordering by aborting the transaction while tree_log_mutex is
> still held. We have a transaction handle here, so this does not need to
> bring back the btrfs_handle_fs_error() call: __btrfs_abort_transaction()
> records the fs error itself, which is all btrfs_sync_log() looks at, and
> the error message put in its place is kept.
>=20
> This is what commit 3810ab40afa5 ("btrfs: abort transaction on error in
> write_all_supers()") already does for the next call in this function.
>=20
> This is reproducible on an unmodified kernel by failing the first
> couple of bios of a transaction commit with fail_make_request while a
> concurrent fsync workload keeps log syncs queued on tree_log_mutex.
>=20
> Fixes: 68d4ece9c30e ("btrfs: don't call btrfs_handle_fs_error() in btrfs_=
commit_transaction()")
> Cc: stable@vger.kernel.org # 7.0+
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/transaction.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 13a7e5f4e08c..ed850bf0546a 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2583,6 +2583,12 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
>  	ret =3D btrfs_write_and_wait_transaction(trans);
>  	if (unlikely(ret)) {
>  		btrfs_err(fs_info, "error while writing out transaction: %pe", ERR_PTR=
(ret));
> +		/*
> +		 * Abort before releasing tree_log_mutex, so a log sync waiting
> +		 * on it sees the fs error and skips writing super_for_commit
> +		 * for this failed transaction. See btrfs_sync_log().
> +		 */
> +		btrfs_abort_transaction(trans, ret);
>  		mutex_unlock(&fs_info->tree_log_mutex);
>  		goto scrub_continue;
>  	}

Reviewed-by: jlayton@meta.com <jlayton@meta.com>
