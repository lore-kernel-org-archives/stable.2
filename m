Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716267;
	b=BkYuNuTlJdO4Yf83uHtO29ZCSOXtzxod6ZBXZZCDajilDC69AVEVnNR/sxnw1wp0htwF
	 HQ2EnDZXFSmEBIzohp+ShSWnAJxkKKb3VDDeTw4fbs3q3SbgeScLTCcpqx9rHWchPMu5G
	 yJKDo4Y/6g4yuJrZhI6ZNh1/MokjiQW6un/1N6inkPgA0z+CnRSeU2XYucQp0As3qgkpj
	 zL1EGFyb3kBJIBQ7gqb4qiGdugrVQI+QxZusVnrKu4ErRjejPTmv4Ipl1o27sKbwTJJ7u
	 ObgoqDnmuDKiFQxDtZ2dViHJOXQysNifrokQJYTpQe/yyTwvi6CXRzR4yyhAjpH2Hrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=+GXjmDSpdPKSM3dvXbu3WCZAHTmv+G6w0ssCMfJAnCM=;
	b=iCc4/Xp4RIGDiCBVWaCAqceW0wxLz6OyUwcDLQ/ix8mQKCaGFl7ANtBs/lJiRWfWc3g2
	 1lswR7US+WhzucKb+Qm/YxhCjM2RYPDWkIMCPmybJe8CITMPmkPNiK3+bZitCPXPLJPL4
	 9bjaEfHFlpLNjHp8h+FKXj17GnFU1llsGzWuU34wQQpCqBnYll/v0ri3sOfBEcrQcfzdE
	 nrfa+XnhsEv30lU4ZUR0w8yL1zVzrtlkNPCvZKHRbDufDz4HXppF0nnvUaRKD+vF4HUZn
	 VcoC5/Fpa+FKbk8ED+ap1FZOW8cMg48X/RZ0skFFpPHk6OlE+8o96it543CYSaRfw6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JAL5xEbx;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691C606D812
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D691C606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JAL5xEbx
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1931ff67a29so8730439c88.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716266; x=1794321066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+GXjmDSpdPKSM3dvXbu3WCZAHTmv+G6w0ssCMfJAnCM=;
        b=JAL5xEbxeRyI5iZfq2c75QvgWSvM8A+hwAkPoB5Ef0uYyHxKF51D+EkIcYAiVT42GW
         O8+rFQnzDXYUm2OXJlerdC3iicYR4aSaSaHH3Ep/VgS3dutNQteQPI38N9cTs923fA4D
         BIryhyqdfWTScigh6MyLKL1CJS2d6DQawQgkmWOyqgp69tkPhN8FiEZNW53On/G87OWp
         kqGTqlIrju9gHXn+A4kicd+uohnWUkqFnZgHPqVrRm/AudeUaSqo5Vxq/cHqmboyto3O
         deySONUwD/jokWH+7+DxV4OSMbR/tJKnNpueSZ3h16f9pmnrEaRKiRgNtstEGOao5RnI
         wqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716266; x=1794321066;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+GXjmDSpdPKSM3dvXbu3WCZAHTmv+G6w0ssCMfJAnCM=;
        b=toWY3ewd2/aUCd1VyPhO3kj87hrC2PdCJjzDc7uaTTxz/hK8T7fmsJ5jjeV8Z/OiYd
         y2wX2UArIMRzON7CN2JE4V975yo361pdOev4e+ArMs0j170oXmEQ0o8GPH8Urcg4svUG
         P/cb/jTDNA/4x+hkmoA7bGVdt8VOO5/V33TlAV5BTYv1z8C3uV//3jJAWXxrGIVjRtYb
         eau3Hn9Rag+zv1zWlpHaQut6iRevWLucDX/V06J9DyE03QvRjGbSJOo9DUzymgLzvEhY
         FqFIrkA2um21lxXj4QE2eyFMFpjOcXYVThGYKYudpRPcDYhjtuyJUELKOaCPtR4rdmR5
         TAnw==
X-Forwarded-Encrypted: i=1; AKwUvByFA6j/K6WOK43pkPoxQWjT3tBLGf48qHBBE4qZ4wRIBCHAZRwo7cWM6NnVpDmKbnx2lagFUYQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wV3QVcx4TyShVHUeFNP8BTSXMjqUgrAbcd6DkeJZ0AX3ubJsl
	Cac1VqMIE/Wtl3LEy8uM4DRckZuXF3RujTHnuAoOMrgLnE+dAdW+qhneoCj+QZkSo2g=
X-Gm-Gg: AYBFou2IQPiRG7KCm6fKum6HaWCXMCEycOMfQ1N1fsp5E7l/z2WdAJVRnWT0EwVFjUY
	wgMg+YSw/VPImxCHPmJvXcIGAy7TN9Zv+mGokjykeDnT80pYoazgtq7EL8xFAS5YZVlv4W5KP6z
	oLOUJgWCAkP5yPi1PJTHUXvzVUzxuJCiVDtQO/rWog+COfXvFsCN57JkHY1524+SSz95vfTNXsw
	J+1WgCWdFP/8LikiO5w1cDQGj05CVd2wAAjSa8m3H+AJp1X4kC64YROxp2YDg+TstqqhLi4kjqa
	M6MjH9BYWW8hBBMNL3+a8GUaZeqEzyv9/Sd1kvyQThlvYMe0Rn8YwsVxLCYj2bnhrWgPcPxJz1i
	+S5+g9D9Bmu9OfERdGps29J8Lf5IZTaHROeCIbqW0ykiBHB7w05yoFAEgLzKjq4g+PErUd1GlEL
	KCJDlTl7Oqf6DIEvN73hBaDHwUwCaKNfosx1H960QPpybelCzk6oa0j5/B+MlLbh3295194zX23
	fRjJCjqiHIouQrsdNSGIddBF+/GkWXjYFZC8ytTSVpWLfveknByrnT1wIL4qq/Io1lcOUE4KyfZ
	ub5i1H+G5CP4072V8auP8JJY+zyjIraVK24Blw3JsHW5/gQC1rl8qrmvlE0fMmJ+0Howh4EBQh8
	8uNqVB3NtDOeh
X-Received: by 2002:a05:7022:c88:b0:194:3a84:e67a with SMTP id a92af1059eb24-1ac5d0da7e6mr18645854c88.41.1793716265860;
        Tue, 03 Nov 2026 06:31:05 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Eugenio Perez <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Ming Lei <ming.lei@redhat.com>, 
 Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261103-virtblk_sync_quiesce-v3-1-f40233f9bdd9@oss.qualcomm.com>
References: <20261103-virtblk_sync_quiesce-v3-1-f40233f9bdd9@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v3] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
Message-Id: <179371626469.3691261.7199603294029974156.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:04 -0700
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 03 Nov 2026 18:32:21 +0800, Cong Zhang wrote:
> blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
> blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
> while the flag is clear. It can then be preempted before it gets a
> request. At that time, it has no queue usage reference, so
> blk_mq_freeze_queue() does not wait for it.
> 
> virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
> blk_mq_unfreeze_queue(). A new request can enter the queue. The old
> dispatcher can run again, use its old flag check, get the new request,
> and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
> reset the device, delete the virtqueues, and free vblk->vqs. The old
> dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
> kernel can crash.
> 
> [...]

Applied, thanks!

[1/1] virtio_blk: use synchronous quiesce in virtblk_freeze_priv()
      commit: 6c6dec7883f8eb10b326bc9d109a4990c885d949

Best regards,
-- 
Jens Axboe



