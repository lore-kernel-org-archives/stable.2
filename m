Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96BB38C42B
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825783; cv=pass; b=KAKSD+vqPcP4c1dQqPb5j5xxGROWPMJI8J00y4jeYgpvKAsYkrJ57B1JZ6ZFio1DLnc38hMjE5G2tqc2WtjSfUmh3l/mV8IWpKjue29Jzf9xQjLyIDGZRfu8ytzktxDPyqItI+sEQtteuJPFDHHK6vkP1CX/G74Jj6DCNlJBZbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825783; c=relaxed/simple;
	bh=Q44R/CsHLtE4MX3OvHihe2deX6qzDwOD99rSjxmgebM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g23WXjisjDAiDJJMaXKlcrZTneMhO0jlY3N3Z3Zl5bivO5sFWrg3e7h3hajxcQOX9r6GdnjagY/XseCwyiq+AI4yz03ax1ndwDJ4NJTBxs5u781l/5AV6b1ffKrhpb/OXDzupFCTBJ0DanTAPh8Ntdfg0RSZqItCvPi057sKhFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PuS14m1B; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PuS14m1B"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9dcf09efaso47777a34.2
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 09:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784825780; cv=none;
        d=google.com; s=arc-20260327;
        b=c7wQX9R19uEHbPVfo4sB+ydSQbzFG9UybkdS4vBy7pTPq755w+ACL11uZBdCiJNLza
         3VKOMsQ9MZptLRVM+5DXI8mSqY2VZmgb/YrkF7DE4rzShImGqAThnimKSkIgCy9r3oRz
         9+5i5iSMALbacj14t8g2YaC1XaUR8QtpRmIlyEnFATwsziupifiMilxoIKduw+XswjZm
         1erzNbT1eGTi0mtlCDVUyESToIZ8nEc51TvfhfSflInvNOxB8skbRH0wAf8rjqnCTJtu
         GNwvVmXgPiLjmvWP8r5MAaAubgSksCLGRFEPxiDwgLQ3IeU6zJzrt4ULIQHh/FqJOnUF
         1Mtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=28h8Mo1J28/lSf6YGH/i0azpidOshn5ZKBa47Y0HxSg=;
        fh=1ipGNQ1bG7oDdznTU2fTMUSrg3Gi+hHZBI8NdmX3H5o=;
        b=RIDBAI/3KH5kLjDIPz9Y1D2wQMT7ivlWvlcmWfXC5iuVysBTu1GkX/DGmSjLeQ2V7Q
         mYu4c2nDgKrDtYIdbTnaxe6i953CuOPKWr/PKGNfwlowzlTkRq1TDFaYY7yqvxo8A3Uz
         JFyMbtAG76L1pc8MidNKM8dIpauLLAeyNoENBLxCNSzs8ub9TgfQx/cxLMf0VJa3WtGO
         5ROsE7CS6qNQ/AuHwt00YfTLOWJ0QG4bp2rHAamNJLMTxoG/9pcTUQJm/LIuuRFSOylq
         wWt1SlKBWhvcP25quul6I/2bcJPJvTuaB8YosO0WpG8iFgndkQZ3mtPGHxXXnrRhhZL8
         UVMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1784825780; x=1785430580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=28h8Mo1J28/lSf6YGH/i0azpidOshn5ZKBa47Y0HxSg=;
        b=PuS14m1BaXDBNdhkOKRoltIfECMUDOvkSbh7d9e85XdoN6sGJjd37qaN7sQOzdKs6x
         ZFX5NKVnMabpIGIybq3touIdTAWfidUTutjHqZQJ7WKkRRf/MIB3ZP3xbBkdFLNHv+rw
         ko7/++3RhAR+q8IhM5+BG24d3f5r+hUM+mNkCzEVC/KeuYujqQxh5Bbzrn2rCRNP7vUQ
         k6JNmLSKrQVnOz60hRgma7NlYkMTg12Qt05tDYyFhIEKW1nYhxGFeH+EuyvaFxis4Ujh
         Yf/XsBJkc4BL0hbjQ274vb9Yg7Z93b1l5x3XmS2bpYkgGRtCAydPLIDgCmTu5NJMCOv2
         Yo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825780; x=1785430580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=28h8Mo1J28/lSf6YGH/i0azpidOshn5ZKBa47Y0HxSg=;
        b=p5k5yUrdFAnJynaauDrjqViRaMjZF7wr7E3y0fc19U8ROWMLLzASGu9XuWhc4odEK8
         QQbyiYhkCuUUtn8VtrEHTR6Ajt4axG2c1JGjvuGnlV0nRePZF+SBjW5gi+NWoydx+o9J
         g4H2ChhfBnKa6kLufNhYnTFztZHi99/SW2RIJDgBnnMWOQdhKo0iv1tYDegSvEEKTxHN
         ZyDkYv7lJ7WuogMQ00uaf8cceAAncauE5ludmvoT79+Xz+4+4MSb3cTVj9rsgnZuZJ2l
         E2HpGlsraYAN39/aOavGa3Wyfd+1SeZMm8NlCzxgBbWbzrNKh/SqMLioP+xmrKTEMs49
         NPjA==
X-Forwarded-Encrypted: i=1; AHgh+RphtX09+fWfFIWjEYrpgX37KLFfADyG7+N/PRZ6VdfAyPVHGCyf1Z11mszKp7k76ebISjiuJks=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/9o+SG1cZl7/iH5LaFxN6EzxcsIZiEjFV0tkDYWvwj1NxpKA
	RnWE424d0NDhbthURI8T/9E0a368aI1J9v7SmNeJwAVxBUow5DJnB4kwz/homlMY9HseB5p5urO
	7vtcQnUrImZSqecjM7LLtoNdyF+hK7AmlCFY8DDeTXhPyIMZuU0+moaoinA==
X-Gm-Gg: AR+sD12boQ8ANDIUlAi3T9x2+9nR3FeY+CvLLJE7ye1IA55Ogk3kPOOe2WHPypdez2B
	/pS5sHLqGtcBTr5DXylvXgnbVnsKtLfiJcGh/fcBaXmNZfdQfdfUyAe8WbBcETSakc6cqsW57zo
	RU1f9uW+ylgaozu95WZY+fgVJxj0ervuX4B4axvDln6AxRnrsUyBBNnkKW3B11PsM8HPXaur8PN
	L27zQLcqVJ40vYrC/A9OcMXEZblGhXPjVzG2f0l9QwshpFxTsrXDVUryQnvDoU=
X-Received: by 2002:a05:6830:4acb:b0:7dc:cc41:bb85 with SMTP id
 46e09a7af769-7ee43a11b62mr2195579a34.0.1784825779594; Thu, 23 Jul 2026
 09:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720032338.461681-1-yangxiuwei@kylinos.cn> <20260720032338.461681-2-yangxiuwei@kylinos.cn>
In-Reply-To: <20260720032338.461681-2-yangxiuwei@kylinos.cn>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 23 Jul 2026 09:56:08 -0700
X-Gm-Features: AUfX_mzT-mFN2jPlf5QOYlATlmjXYMbgaUCUircqzzNnT5cQ2uj1Cl2XHm3Grso
Message-ID: <CADUfDZpAW261MhFJg434=4nZFMD7mV=LL7F-ZiAWPa7dYvGpcQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi: bsg: fix TOCTOU in io_uring passthrough command setup
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, 
	rc@rexion.ai, axboe@kernel.dk, fujita.tomonori@lab.ntt.co.jp, 
	bvanassche@acm.org, linux-scsi@vger.kernel.org, io-uring@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 8:27=E2=80=AFPM Yang Xiuwei <yangxiuwei@kylinos.cn>=
 wrote:
>
> From: Rahul Chandelkar <rc@rexion.ai>
>
> scsi_bsg_uring_cmd() reads bsg_uring_cmd fields from the shared mmap'd
> SQE via io_uring_sqe128_cmd(). On the inline path the SQE is still
> user-writable, so request_len can change between the bounds check and
> copy_from_user(), overflowing scmd->cmnd.
>
> Snapshot request/request_len and the transfer fields used for buffer
> mapping with READ_ONCE before validation and reuse. Pass the stable
> map arguments into scsi_bsg_map_user_buffer() so it does not re-read
> the SQE.
>
> Fixes: 7b6d3255e7f8 ("scsi: bsg: add io_uring passthrough handler")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20260527105931.3950913-1-rc@rexion.ai
> Signed-off-by: Rahul Chandelkar <rc@rexion.ai>
> Co-developed-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
> Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
> ---
>  drivers/scsi/scsi_bsg.c | 40 ++++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/scsi/scsi_bsg.c b/drivers/scsi/scsi_bsg.c
> index e80dec53174e..c57ce01379de 100644
> --- a/drivers/scsi/scsi_bsg.c
> +++ b/drivers/scsi/scsi_bsg.c
> @@ -76,12 +76,10 @@ static enum rq_end_io_ret scsi_bsg_uring_cmd_done(str=
uct request *req,
>
>  static int scsi_bsg_map_user_buffer(struct request *req,
>                                     struct io_uring_cmd *ioucmd,
> -                                   unsigned int issue_flags, gfp_t gfp_m=
ask)
> +                                   unsigned int issue_flags, gfp_t gfp_m=
ask,
> +                                   bool is_write, u64 buf_addr,
> +                                   unsigned long buf_len)
>  {
> -       const struct bsg_uring_cmd *cmd =3D io_uring_sqe128_cmd(ioucmd->s=
qe, struct bsg_uring_cmd);
> -       bool is_write =3D cmd->dout_xfer_len > 0;
> -       u64 buf_addr =3D is_write ? cmd->dout_xferp : cmd->din_xferp;
> -       unsigned long buf_len =3D is_write ? cmd->dout_xfer_len : cmd->di=
n_xfer_len;
>         struct iov_iter iter;
>         int ret;
>
> @@ -104,21 +102,29 @@ static int scsi_bsg_uring_cmd(struct request_queue =
*q, struct io_uring_cmd *iouc
>                                unsigned int issue_flags, bool open_for_wr=
ite)
>  {
>         struct scsi_bsg_uring_cmd_pdu *pdu =3D scsi_bsg_uring_cmd_pdu(iou=
cmd);
> -       const struct bsg_uring_cmd *cmd =3D io_uring_sqe128_cmd(ioucmd->s=
qe, struct bsg_uring_cmd);
> +       const struct bsg_uring_cmd *cmd =3D
> +               io_uring_sqe128_cmd(ioucmd->sqe, struct bsg_uring_cmd);
>         struct scsi_cmnd *scmd;
>         struct request *req;
>         blk_mq_req_flags_t blk_flags =3D 0;
>         gfp_t gfp_mask =3D GFP_KERNEL;
> +       /* Snapshot SQE fields used for validation and buffer mapping. */
> +       u64 request =3D READ_ONCE(cmd->request);
> +       u32 request_len =3D READ_ONCE(cmd->request_len);
> +       u64 dout_xferp =3D READ_ONCE(cmd->dout_xferp);
> +       u32 dout_xfer_len =3D READ_ONCE(cmd->dout_xfer_len);
> +       u64 din_xferp =3D READ_ONCE(cmd->din_xferp);
> +       u32 din_xfer_len =3D READ_ONCE(cmd->din_xfer_len);
>         int ret;
>
>         if (cmd->protocol !=3D BSG_PROTOCOL_SCSI ||
>             cmd->subprotocol !=3D BSG_SUB_PROTOCOL_SCSI_CMD)
>                 return -EINVAL;
>
> -       if (!cmd->request || cmd->request_len =3D=3D 0)
> +       if (!request || request_len =3D=3D 0)
>                 return -EINVAL;
>
> -       if (cmd->dout_xfer_len && cmd->din_xfer_len) {
> +       if (dout_xfer_len && din_xfer_len) {
>                 pr_warn_once("BIDI support in bsg has been removed.\n");
>                 return -EOPNOTSUPP;
>         }
> @@ -131,20 +137,20 @@ static int scsi_bsg_uring_cmd(struct request_queue =
*q, struct io_uring_cmd *iouc
>                 gfp_mask =3D GFP_NOWAIT;
>         }
>
> -       req =3D scsi_alloc_request(q, cmd->dout_xfer_len ?
> +       req =3D scsi_alloc_request(q, dout_xfer_len ?
>                                  REQ_OP_DRV_OUT : REQ_OP_DRV_IN, blk_flag=
s);
>         if (IS_ERR(req))
>                 return PTR_ERR(req);
>
>         scmd =3D blk_mq_rq_to_pdu(req);
> -       if (cmd->request_len > sizeof(scmd->cmnd)) {
> +       if (request_len > sizeof(scmd->cmnd)) {
>                 ret =3D -EINVAL;
>                 goto out_free_req;
>         }
> -       scmd->cmd_len =3D cmd->request_len;
> +       scmd->cmd_len =3D request_len;
>         scmd->allowed =3D SG_DEFAULT_RETRIES;
>
> -       if (copy_from_user(scmd->cmnd, uptr64(cmd->request), cmd->request=
_len)) {
> +       if (copy_from_user(scmd->cmnd, uptr64(request), request_len)) {
>                 ret =3D -EFAULT;
>                 goto out_free_req;
>         }
> @@ -158,8 +164,14 @@ static int scsi_bsg_uring_cmd(struct request_queue *=
q, struct io_uring_cmd *iouc
>         scmd->sense_len =3D cmd->max_response_len ?
>                 min(cmd->max_response_len, SCSI_SENSE_BUFFERSIZE) : SCSI_=
SENSE_BUFFERSIZE;

cmd->max_response_len is passed through here, shouldn't it be accessed
using READ_ONCE() too? Omitting READ_ONCE() only seems safe for values
that are ignored (except for a possible check that they match a fixed
value).

Ditto for cmd->timeout_ms later in this function.

Best,
Caleb

>
> -       if (cmd->dout_xfer_len || cmd->din_xfer_len) {
> -               ret =3D scsi_bsg_map_user_buffer(req, ioucmd, issue_flags=
, gfp_mask);
> +       if (dout_xfer_len || din_xfer_len) {
> +               bool is_write =3D dout_xfer_len > 0;
> +               u64 buf_addr =3D is_write ? dout_xferp : din_xferp;
> +               unsigned long buf_len =3D is_write ? dout_xfer_len : din_=
xfer_len;
> +
> +               ret =3D scsi_bsg_map_user_buffer(req, ioucmd, issue_flags=
,
> +                                              gfp_mask, is_write, buf_ad=
dr,
> +                                              buf_len);
>                 if (ret)
>                         goto out_free_req;
>                 pdu->bio =3D req->bio;
> --
> 2.25.1
>
>
