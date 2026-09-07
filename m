Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2362D12EC
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 23:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788822696; cv=pass; b=s6xPOVK5zYpqv6yY1ytiXS0ZuTbCd/PbbRJIPTDpuS/Pianyc/Wu71pNhEOnnlPP78KDXT5HdmFhhhU/MS1TSbLotSm6pN2FIo7Y79g7aqxMoEq1w8Zo5tvw+Vvyba+LVcBK7kmv2YhgEAvCpZWXNvaGSfBFO1jaWx+o0l/6GaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788822696; c=relaxed/simple;
	bh=FWN3padbPY6LQf9RJI6NzHJX44JvjlPYEx8mJNn/Xus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ci10XQTE894kb1E3x3OK8vkogaD/xygggx6t8zoTlVxjb0y65luW+C2uLOx5xlJ7a/D55FxdR3F9rj9erV0Ux9c3a5ACgkWaDo1Z81y+w6Lg2JPmqtPKYcRM0W9vbhVYbBMbs7mGTotoRZugk8yz/UGkTTKTLYyujB509fpX3rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdKrsrwY; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdKrsrwY"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so56106215e9.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 16:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788822693; cv=none;
        d=google.com; s=arc-20260327;
        b=SIEQSioaarZuTA6X2Devjqvw3AlbHnPsJtnuoLGrHzTv13SQuGuQATPqaEI1cAtLbq
         Splhryo2BRF8r6bqw9jSK8QL0sO7d+N/J8bn2UXXmrg0wkr/81E+QHavjAOjeidS67Xc
         RLkZA8DrtxtITE11vVQlR7voB84ga7BZ2ypaESMKm+kU44ov5hNmJ2sS9hdZPzYTEfLC
         psp4G0GuJMgZBV/0kDU1xmojntZZfeXhKMsNwiBoDpJz9foiwdHDImYT3mEDJ9qB7b91
         HbfAZag2nEjU+HpktxjnatDLqOGLybGt7YA5M1lKGjjZPR3WaDUL06b3tfWM68rmef3r
         hYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZqYGWCrCxac5SzvL96KWqfYKXYEqviRZTXDmQqhana8=;
        fh=cfuv0aTFL0UbEFbwULYB6y7Zv+L3u799np2iJ0x4gps=;
        b=ThBqg3cEW5GDxE+FdqOAphN1emZ9qeu1q3lV3q9eomQiSUBwobvV3QLjlTV84pHel8
         o+e3MHqDqpLLr3gkyHNVxxTwcUtBAs4txbcJ1myaY9m/VNFstyT9XCC49NnykXAf1Y/d
         th57sDnpgQDe7o3lwbQdy+ezoqi7qgyWsLdthKdE2LRQbEyVe7nywAb1rhOGqwst5eYe
         /xNfYkDj4wCb6e4J3H2zqveAvSzXxhIXK96UvIUH0w8fiDTwGoovbj5Zo6HXKAgnBoWA
         CTwm9udgMnEYa3Yfq5CBwy8haNa5SNomwgw/2EoLVwFbKe3kV0hDEvK+g0u+jpXOOhNq
         sIQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788822693; x=1789427493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZqYGWCrCxac5SzvL96KWqfYKXYEqviRZTXDmQqhana8=;
        b=ZdKrsrwYGxLlzPBYxTy6QK4u13VDYzJCWlxQRalBzxf/Pumx17vTh314R2fSHMbAHP
         geaLShZhvP9OzVZRb2AXjVsOntpz1IIPQjiUHNs4O9a6/4/GadgAlzafZbz8+iBWM4zu
         T1EhqlkWbPb8MRzY0CmMXWgS1ABZLiQzE1QVB23DGPvZW6pHBdmrgD4uTaeJTr9mV1At
         3Z8zOlWj+QdFd5mvelO1lG3PZh1U4foTLmSfnWm45AbVdzeuJZqY0Tl5Yvyg+DR4/P3q
         Ydlv1xyYLYEkPHtkx56Gg9cEsajRoxAKv70citJWtMYHK+1ph19fdzq+hFUL2M3JKaFU
         QTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788822693; x=1789427493;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqYGWCrCxac5SzvL96KWqfYKXYEqviRZTXDmQqhana8=;
        b=Afww7xrAito2LjyHvyBNLD6wtAlLbbp1L8m10IKGSO56XPGB6kd10U45JMxvrfOIJS
         ediaAlrHvsP2uEL2quESL2AqchNmvu9OfdjEdhyhG2p7y4tfhIrMabAknJjozKtQZxmC
         bGaYjf0JstZ0aItfconINfwMEh2RPtUVm/+E6EFN8wTVd/yvjqZkYb4D+Xds777hJX4h
         FiSIQvGQlLGCltcur4M5mfofI+hoqR/a2b8gk4+AQVmE9Zbyxb3TUjyO4q2pi3zYH6Xn
         jlg6EzUt9z1x9Niok3b4hiAwagitHpXbyIVbqB8J8bUQ1QyfSpANwmxKJaAbKmJC9DCT
         fIzg==
X-Forwarded-Encrypted: i=1; AKwUvBxmukYD19F9fkCadpwuce4gbyLpMBvC+aqgzObCCTUA4Te3v4rzus9XfeX9Z+7cJ27c/TruYuA=@vger.kernel.org
X-Gm-Message-State: AFuF++mE3ev3jouruAkxMHjO9s9R4qRBhSFjlRIysouCedkiwcQ20khT
	nw22ZUtRWuZ1mheSs5kedI8jlSEgvIWuNlAc5X0H3v298YfbPELlfG32exyBevwFpx7497KTii7
	NMl2xvOSF+6Giy4UzMTRRn4wR04EXacI=
X-Gm-Gg: AYBFou33Ghw4MMjNqb8fkZ6Qnymue2otuVKkcfrzNR6UDZw1PfVTTabmBgqYl/eHq+v
	vQgYGrwrq2dVhw75IPZXcl7cp9Pelqso+vOAePzyiLuZS/sd3QvB8ldV+SoIVXUnMOG6X5RcuOL
	xe3nNBQqOhXLJhJUZpIwQDTj2yTcEDUfN9QooIY/7JLdKy63xBujlh12+mQTvF7X0tWqHLqPbNO
	4naQy71iQWzkl4psHAOlrj61FEdcCOqa/+5h5ICtSqrN1rCHM5Xz0PImioncJjS/fC2ZM7MlBzE
	HCv4vRMQuAnjvfhA7uywnd5TO9tcg+IcvfcDxubKhEBhPA==
X-Received: by 2002:a05:600c:1f87:b0:49d:827:e5b6 with SMTP id
 5b1f17b1804b1-49d0827e5ffmr138059395e9.20.1788822692868; Mon, 07 Sep 2026
 16:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901014718.2835558-1-kumar.shivam43666@gmail.com>
In-Reply-To: <20260901014718.2835558-1-kumar.shivam43666@gmail.com>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Mon, 7 Sep 2026 19:11:22 -0400
X-Gm-Features: AcwNN1Uw95u448KfGp18iNkp5UImmKlHY0LryViVoABxOhMY6syB8F7R59l4fMI
Message-ID: <CA+ysrSLTfXxt2EsbU0o3BehqS1nCtjDfR4wOUUJ__6LOhYSjSw@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: fix a hang on queue teardown with data digest
To: linux-nvme@lists.infradead.org
Cc: Greg KH <greg@kroah.com>, security@kernel.org, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 9:47=E2=80=AFPM Shivam Kumar
<kumar.shivam43666@gmail.com> wrote:
>
> With data digest on, a command that has received all its data waits for
> the digest in NVMET_TCP_RECV_DDGST. has_data_in() is already false there,
> so need_data_in() is too, and nvmet_tcp_uninit_data_in_cmds() skips it on
> teardown even though it still holds the nvmet_req_init() reference. The S=
Q
> percpu_ref never drains, nvmet_sq_destroy() blocks forever in
> wait_for_completion(), and the nvmet-wq release worker is stuck.
>
> An unauthenticated host on an allow_any_host subsystem hits this by
> negotiating data digest, sending a write's data but not the trailing
> digest, and closing the connection. Each leaked command wedges a release
> worker; a few stall queue teardown entirely, and with hung_task_panic the
> box goes down.
>
> Drop the reference for a command left in RECV_DDGST from
> nvmet_tcp_release_queue_work(), before rcv_state is cleared. A command
> that failed nvmet_req_init() never took one, so skip it.
>
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
> Assisted-by: Claude
> ---
>  drivers/nvme/target/tcp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1640,6 +1640,19 @@
>         nvmet_tcp_restore_socket_callbacks(queue);
>         cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
>         cancel_work_sync(&queue->io_work);
> +
> +       /*
> +        * A command that has received all of its data and is only waitin=
g
> +        * for the data digest sits in RECV_DDGST: need_data_in() is alre=
ady
> +        * false, so nvmet_tcp_uninit_data_in_cmds() below skips it, yet =
it
> +        * still holds the reference from nvmet_req_init(). Drop it here,
> +        * while rcv_state still reflects it, so the SQ percpu_ref can dr=
ain
> +        * and nvmet_sq_destroy() can complete. INIT_FAILED took no ref.
> +        */
> +       if (queue->rcv_state =3D=3D NVMET_TCP_RECV_DDGST && queue->cmd &&
> +           !(queue->cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +               nvmet_req_uninit(&queue->cmd->req);
> +
>         /* stop accepting incoming data */
>         queue->rcv_state =3D NVMET_TCP_RECV_ERR;
>
> --
> 2.34.1

Gentle ping on this one.
