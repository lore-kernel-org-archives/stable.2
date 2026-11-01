Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793563151;
	b=Z4KlRAhfC2izuYrn9ULQ7RzsJSvIl3g04rBsGLsijfBALqn1zMRT+D9IfTFyfa2Eelkc
	 j18XFU7+vBkeOQGOmGnuRC8B0teQudiSpRVAW/eOyBirrleNRbSr3oaFSsyKd3qVCf3Aj
	 UEsDtqOd7Ff6jYvvmCoRTE0UAWgwUR8qkC/cWWPt6b01VhD1jOEAhBYZb0uzQrAdTCuyO
	 1unzhVAUcyK8VAPCA9eLt+2sB/7Zd/QD34YkWbnrd0pBXmX2FVpZWQvA2XF3PHg0JsYJO
	 nS83iQbqrPi3ppCvVRjxV+ONe7wPn1ieiXoFI2NaIVnLtHG3baIjjaqmRGkhCjZFODw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563151;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=5tZBCum4g5P+Lsa7iuHJrRJRPWG61w7k3MlEkof9bx0=;
	b=hHY17WHRnkh4XLRNy7KE9nn09QTePG9+R/a1DgvC4wl90SY04vm6J0FU9NxNmSew2rtW
	 EE5PvuvyffLh3uh1earhKLnwdhq7PjYSRA1K5WyWasLfe5ZOaZ0g5MO08v+MUwL94H/bk
	 rf4UkXFuZXVm3lh231UqCc61KatSRFrKcPfilloxrztQcd9SSlwjQWNiF3iC1nNIeJlX3
	 s9keu1L3uqcKNaEGXrEe7TTUrwMzrdMetm00hEH21mi/eo9D9maA5BKj3u2xNdIphuqRK
	 YXu+1h1Np+o+/w2FSg8sHljBzdqeXUc90MlonYYoe9ZgCJRV+TfPVRRdezvXAIGiNtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCOxMh4+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76F8606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCOxMh4+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360961F00919;
	Sun,  1 Nov 2026 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793563150;
	bh=5tZBCum4g5P+Lsa7iuHJrRJRPWG61w7k3MlEkof9bx0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=MCOxMh4+29HCZWqMmtuXxQotRNftBm3dO2ilrqHWPJfPNR7sw1vyoImUblO0O5pH9
	 rZcsiO3lpV1dw8VT8uzdwPcZo7sJ8pplM3OU/DeAanyn9hcOXrY2nvEK2GDkMBSnwh
	 0gMiC4F2PFz8PPz8YiT0Gc4+hjec74N9FBa3ucC/xcqv1coEcA324hYipjh+ecE9yu
	 yvnCDrL7K2M2Qt5dqgGOgHxxQQUs4UQTO2LiLfuzQZdMlf0k3DQz3bbRvYRy/xju+7
	 Rvzr2oSEi+DlN8fFnwpwYySopzxBiZMjuPJqLJp2nwXeo0Rty2Y9TsBtVlpIUj05wa
	 RwuGNrXyGPuig==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7E9C4F40068;
	Sun,  1 Nov 2026 14:59:09 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 01 Nov 2026 14:59:09 -0500
X-ME-Sender: <xms:DZrnapNaLNNq7lyea9m1STxyhQLTp8xFWoUcNjbt9xXY6rZ8fg6QSg>
    <xme:DZrnamx2VZiJdj5gaOaYLGs1PL3nSSkARO8piuzGxB2rtKVukHzDabWinVXHMfm0V
    gFPna2d_xBZ8vTQCTYWNTmRKJqLVGyQGcjd9plnUbWqvWHOrOx26-Q>
X-ME-Proxy-Cause: dmFkZTGIy47bLtwb7DWemBjcucoCW9BXJ/VjdwGv0fUoAahks0dYJT6hY3y2XdrSRVnTSt
    Ezqi5+lgFxyFoyDlnBRgJhRO6dxZq5eUdgGycOVLNjt9Ct3hQUDh/aawtUVMlkD4oT/DjU
    YPRGGM348ej6EB7VFJ0mE/YJVmtpb6m1FIt15l+RYExVO20hws2TyUI7g0jwCkSqlpz2lz
    AZr4C1rJijZAiHBwvMssdjNfSjiYG3zY5wPnWPATukph5EtRcRrgDE+A4bLmFbpM9Zzfuf
    O8pPeIC7HzUjf8P38V+BxekI5N24Dvc+Binfbj/i6Qls/DEawsp/xvWlTPiLOQ58h1Ysc2
    a5E84Ioses3jPXi0e01b4S8PKBxmu8gvEEooPrMbYOVNSruGpKVDNevcW6UsS8UiyXV+Gi
    bzApWAw/JHDkgI6TemK5OJoJjY7gQJetDphaTrVyPSUAoQ2rWCDXGwG0erm1plHOMdFv3U
    2B8uHHaw/eElOBpQirAFy53oV0kudoEm8toMm40tbvXSlclQ0+SCRFhrwaIV6tWIcsGmN+
    R1YWcA57Wy5uKWIVfY+9ROc3ssbOeFvHiW6bQMKzhWAdHtqeHyYGtU1Tp/6tFnNGXqnk2J
    4kfx+62Q2HG6cb5GQnND2Z5KpktgYMshYfdabzXiWGRAz757PYfZ/mfZrtjQ
X-ME-Proxy: <xmx:DZrnai0N7DdaUSWe9IhhHv2T0pTKh_LDvyeddqInaL16CKl0k2oPHg>
    <xmx:DZrnavJpIWE43bN7vfqbzeej-73A-siT8OXLz2ca5BT_rQwPhB0Z2g>
    <xmx:DZrnaqzjW1tREisSNQZxoduDbQoH5ZIgLpPkLPcigNVUGr_RK-DiFA>
    <xmx:DZrnalVzpQ1ZmicmW7_yVHSnYnMBdrDQIcsbWrjnqVC__HyYPRl1lg>
    <xmx:DZrnaig3-RAD1znOhTTVxV2VVZVigI3wlQHSwQCrMAvTQq5NvQyMgLeh>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 58B9C782738; Sun,  1 Nov 2026 14:59:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AoE0oTd0Q-ZZ
Date: Sun, 01 Nov 2026 14:58:49 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 stable@vger.kernel.org, "Nickolai Zeldovich" <nickolai@csail.mit.edu>
Message-Id: <151c1af3-cd51-4f40-8caf-43a30ba184ed@app.fastmail.com>
In-Reply-To: 
 <20261101-work-libfs-offset_readdir-v2-0-c621125b56d1@kernel.org>
References: <20261101-work-libfs-offset_readdir-v2-0-c621125b56d1@kernel.org>
Subject: Re: [PATCH v2 0/3] libfs: fix readdir of offset directories
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, Nov 1, 2026, at 5:57 AM, Christian Brauner wrote:
> readdir on tmpfs walks d_children and only uses the offset tree to map
> the file position back to a dentry. d_children and offset order
> disagree after a rename over a name, an exchange or a wrap of the
> offset allocator. An unlink between two getdents64() calls then makes
> the walk skip entries or return the whole directory again. So walk the
> offset tree itself in descending offset order.
>
> v1 did that with a full tree descent and a reference for every entry
> and was quite a bit slower. Now the walk keeps one ma_state for the
> whole call and takes no references at all. That relies on all writers
> holding i_rwsem exclusive while readdir holds it shared, and the maple
> tree only allows that if i_rwsem is the lock of the tree. The first
> patch makes it so, and lockdep now checks the writers. The last patch
> stops an lseek() past the end from returning the whole directory again.
>
> 1M entries on tmpfs, getdents64() with a 32k buffer: 146ms before,
> about 230ms with v1, 114ms now. Four processes listing the directory at
> the same time: 470ms per listing before, 113ms now.
>
> Tested with Nickolai's reproducer, generic/736 and a seek-after-closedir
> test, on tmpfs and on tmpfs exported over NFSv3 and NFSv4.2, on KASAN
> and lockdep kernels. I also wrote a TLA+ model of the walk (cf. [1]).
>
> [1]: 
> https://github.com/brauner/linux-formal/tree/main/kernel/libfs/offset-readdir
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Changes in v2:
> - Make i_rwsem the lock of the offset tree.
> - Keep one ma_state across the walk and take no references (Chuck).
> - Don't return the whole directory again after an lseek() past
>   DIR_OFFSET_EOD.
> - Link to v1: 
> https://patch.msgid.link/20261030-work-libfs-offset_readdir-v1-1-ed733c14229e@kernel.org
>
> ---
> Christian Brauner (3):
>       libfs: make i_rwsem the lock of the offset tree
>       libfs: walk offset directories in offset order
>       libfs: end offset readdir at positions past DIR_OFFSET_EOD
>
>  fs/libfs.c         | 133 +++++++++++++++++++++--------------------------------
>  include/linux/fs.h |   2 +-
>  mm/shmem.c         |   2 +-
>  3 files changed, 54 insertions(+), 83 deletions(-)
> ---
> base-commit: b44341e39d856e4cc6ad8ed94ebffd440f39846c
> change-id: 20261030-work-libfs-offset_readdir-807d3b774260

Reviewed-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
