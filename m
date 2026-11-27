Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795742188;
	b=GtgXSjLBd/EEyjCQ1+/5W3GkbxAf/sDM3H6AZl6mnDZ1wKb3xl0roY24JA1ZbCWSHZA1
	 TWg8NZOvCFlkuACCByBlj683Im4sc1wl8JXSHcfK8S8/nugLGiyjrJ3QhWi8QF9I9HkqX
	 y55fpvf/ae9KnLIcC5RE5N0yXig7TyWS8gINZbcKHRl8GzF/vNif6xP5g4FrYUP3Xfq/C
	 nSG8L4fjx7Chl4/vL+duP5FhA3B1GpvPKJXY4JNvD57/NaWqdAGaq+7nx3e7jcfxb8ofo
	 ggycnvHV5nyOVEg/BiRuaSTCned2cm6qVJrS/qukeV6HFguUxXddDyH5ydUXLH2msBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742188;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=uoROFmhP1WYJ0D7qo7bgDD0qrvZazeRoAO22rJ7paFI=;
	b=Q69VuC7nurjTapIKybXYypZPd6TXw3sDkpaSJ+ULa7d0MGazishRMqkKJKr0LE2S49Eu
	 p+8T1RxZcKTU3BWmpsWzZ/u/TPU196pW8qSVf7RdwfxcpnQjytnvVon24fSi0tGbwgaM3
	 GhQfmvwy5mosw2PCCbnEdd4SxAnGVhsfMHc585qQbbjFRfGmYhNfplAg20JscS4BuIwLi
	 aDlDQvHIB0vjuMH3rjuBH2TUaMbcEwMV+JY7mxpXgzOv/diQwwBAEVVHzoZByvQd7S6Sy
	 2b0ngk4H7aIODjfZ2k+YLS9AHIZ9JpU/PlJ9hwzX2MQK5xN6rOhswWTssy+EWN9Ahmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=dl3KjdNS;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CD0606A31E;
	Fri, 27 Nov 2026 01:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06CD0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=dl3KjdNS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795742186;
	bh=fnxwTCBIp/6YoseXa/LQt+NHKClglW/6bHL9ddm0ZqM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dl3KjdNSiZycpI+uXT0jRnYMJ+k41eJauRhiAyE79eA0MtMLv6tnn1jPXX+rBshuW
	 /cbOglNAFnWkksUMFhNsHobZHXfpqFD74RJ3yq1u4N6lvZKmMGxP14JtpWcrlnta3u
	 bSX7fjPBjKMcaDS4WBP80mtK0w+xR5jaDOpuRVNX9hUmjbUrwhREhe7qfyn9wBQS4M
	 BHAmNzGLd0FJLvd6vPuwEd5q5GqjMbhfANs/EzNN+nCJKDHx/XHqQe+5sRYcsUfz6u
	 cOWcS0ICiNIGfTKdbHDbq4nOwTpXv2ebbIUsIO1V5IFvkf6VygA68FaL8S1ls/febq
	 ibdhrWSTTyJLg==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4F64D17E0CF4;
	Fri, 27 Nov 2026 02:16:24 +0100 (CET)
Message-ID: <44f3c5e0117b9a3242bf247102df5000d009b721.camel@collabora.com>
Subject: Re: [PATCH v2 5/9] media: chips-media: wave5: finish a job only once
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lafley.kim@chipsnmedia.com, b-brnich@ti.com, hverkuil@xs4all.nl, 
	nas.chung@chipsnmedia.com, stable@vger.kernel.org
Date: Thu, 26 Nov 2026 20:16:22 -0500
In-Reply-To: <20261109052853.110-6-jackson.lee@chipsnmedia.com>
References: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
	 <20261109052853.110-6-jackson.lee@chipsnmedia.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-GVO2R+Bz5ri09iN1whnj"
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

--=-GVO2R+Bz5ri09iN1whnj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 09 novembre 2026 =C3=A0 14:28 +0900, Jackson.lee a =C3=A9crit=C2=
=A0:
> From: Jackson Lee <jackson.lee@chipsnmedia.com>
>=20
> v4l2_m2m_job_finish() checks that the context owns the current job, but
> not which job it is, so a second finish from the same context clears
> m2m_dev->curr_ctx all the same. v4l2_m2m_try_run() picks the next job
> under job_spinlock, drops it, and only then reads curr_ctx again to hand
> its priv to device_run(). A stray finish landing in that window makes
> that read return NULL and the decoder oopses:
>=20
>   Unable to handle kernel NULL pointer dereference at virtual address
>   0000000000000358
>   Workqueue: events v4l2_m2m_device_run_work [v4l2_mem2mem]
>   pc : v4l2_m2m_try_run+0x78/0x140 [v4l2_mem2mem]
>=20
> The decoder finishes jobs from seven places: device_run() itself, the
> completion IRQ, and job_abort(). None of them tracked whether a job was
> still outstanding, so the same job was finished twice whenever the IRQ
> and device_run() both reached the end. Instrumenting the call sites over
> 150 s of a three-stream run counted 63 finishes with no job to finish,
> two of them a plain double finish.
>=20
> Take ownership of the slot once per device_run() and let only the winner
> call in; whoever loses the race now returns without touching the shared
> state. Also compare v4l2_m2m_get_curr_priv() against this instance rather
> than testing it for NULL, which let one instance finish another's job.
>=20
> job_abort() must not end a job that device_run() is still running or is
> about to run. v4l2_m2m_try_run() sets TRANS_RUNNING before it calls
> device_run(), so v4l2_m2m_cancel_job() can get there first, and a finish
> from job_abort() then releases cancel_job()'s wait early: try_run()
> reads a curr_ctx that is already NULL, or release() frees the instance
> under device_run(). Hold a per-instance run_lock across device_run() and
> take it in job_abort(), which then finishes through the same ownership
> check. The only job left for it to end is one device_run() handed over
> to the DEC_PIC completion after EOS; device_run() finishes every other
> one itself. job_abort() no longer returns early on a failed state
> switch, so that held job is still ended and streamoff cannot hang on it.
>=20
> start_decode() no longer finishes the job when it fails: device_run()
> does that on its way out, as for any run that queued no DEC_PIC.
>=20
> Fixes: a176ac5e701f ("media: chips-media: wave5: Improve performance of d=
ecoder")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---
>  .../chips-media/wave5/wave5-vpu-dec.c         | 93 ++++++++++++++-----
>  .../platform/chips-media/wave5/wave5-vpuapi.c |  1 +
>  .../platform/chips-media/wave5/wave5-vpuapi.h |  3 +
>  3 files changed, 73 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index a314813a6b4d..3ecf535f5622 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -102,6 +102,29 @@ static const struct vpu_format dec_fmt_list[FMT_TYPE=
S][MAX_FMTS] =3D {
>  =09}
>  };
> =20
> +/* bit in vpu_instance.job_flags */
> +#define WAVE5_JOB_RUNNING=090
> +
> +/*
> + * Hand the shared job slot back, exactly once per device_run().
> + *
> + * v4l2_m2m_job_finish() only checks that the *context* owns the current=
 job,
> + * not which job it is, so a second finish from the same context clears
> + * m2m_dev->curr_ctx -- and it may do so for the job v4l2_m2m_try_run() =
has just
> + * put there and is about to hand to device_run(), which then dereferenc=
es NULL.
> + *
> + * device_run(), the completion IRQ and job_abort() all reach for this a=
nd any
> + * of them may get there first, so ownership is taken atomically and onl=
y the
> + * winner calls in.
> + */
> +static void wave5_dec_finish_job(struct vpu_instance *inst)
> +{
> +=09if (!test_and_clear_bit(WAVE5_JOB_RUNNING, &inst->job_flags))
> +=09=09return;
> +
> +=09v4l2_m2m_job_finish(inst->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
> +}

To me, the complexity is a side effect of how the performance issue was
addressed without doing a redesign. I'm fine letting this go, but it will g=
et
harder and harder without a proper cleanup and redesign.

> +
>  /*
>   * Make sure that the state switch is allowed and add logging for debugg=
ing
>   * purposes
> @@ -245,8 +268,7 @@ static int start_decode(struct vpu_instance *inst, u3=
2 *fail_res)
>  =09=09mutex_unlock(&inst->feed_lock);
>  =09=09set_instance_state(inst, VPU_INST_STATE_STOP);
> =20
> -=09=09dev_dbg(inst->dev->dev, "%s: pic run failed / finish job", __func_=
_);
> -=09=09v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
> +=09=09dev_dbg(inst->dev->dev, "%s: pic run failed", __func__);
>  =09}
> =20
>  =09return ret;
> @@ -375,7 +397,7 @@ static void wave5_vpu_dec_finish_decode(struct vpu_in=
stance *inst)
>  =09ret =3D wave5_vpu_dec_get_output_info(inst, &dec_info);
>  =09if (ret) {
>  =09=09dev_dbg(inst->dev->dev, "%s: could not get output info.", __func__=
);
> -=09=09v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
> +=09=09wave5_dec_finish_job(inst);
>  =09=09return;
>  =09}
> =20
> @@ -388,7 +410,7 @@ static void wave5_vpu_dec_finish_decode(struct vpu_in=
stance *inst)
> =20
>  =09if (!vb2_is_streaming(dst_vq)) {
>  =09=09dev_dbg(inst->dev->dev, "%s: capture is not streaming..", __func__=
);
> -=09=09v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
> +=09=09wave5_dec_finish_job(inst);
>  =09=09return;
>  =09}
> =20
> @@ -469,13 +491,13 @@ static void wave5_vpu_dec_finish_decode(struct vpu_=
instance *inst)
>  =09}
> =20
>  =09if (inst->sent_eos &&
> -=09    v4l2_m2m_get_curr_priv(inst->v4l2_m2m_dev)) {
> +=09    v4l2_m2m_get_curr_priv(inst->v4l2_m2m_dev) =3D=3D inst) {
>  =09=09struct queue_status_info q_status;
> =20
>  =09=09wave5_vpu_dec_give_command(inst, DEC_GET_QUEUE_STATUS, &q_status);
>  =09=09if (q_status.report_queue_count =3D=3D 0 &&
>  =09=09    q_status.instance_queue_count =3D=3D 0)
> -=09=09=09v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
> +=09=09=09wave5_dec_finish_job(inst);
>  =09}
> =20
>  =09if (inst->queuing_fail) {
> @@ -1685,6 +1707,9 @@ static void wave5_vpu_dec_device_run(void *priv)
>  =09int ret =3D 0;
>  =09bool cmd_issued =3D false;
> =20
> +=09mutex_lock(&inst->run_lock);
> +=09set_bit(WAVE5_JOB_RUNNING, &inst->job_flags);
> +
>  =09dev_dbg(inst->dev->dev, "%s: Fill the ring buffer with new bitstream =
data", __func__);
>  =09pm_runtime_resume_and_get(inst->dev->dev);
>  =09if (!inst->retry) {
> @@ -1809,36 +1834,55 @@ static void wave5_vpu_dec_device_run(void *priv)
>  =09 * stalling every instance sharing the VPU.
>  =09 */
>  =09if (!inst->sent_eos || !cmd_issued)
> -=09=09v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
> +=09=09wave5_dec_finish_job(inst);
> +=09mutex_unlock(&inst->run_lock);
>  }
> =20
>  static void wave5_vpu_dec_job_abort(void *priv)
>  {
>  =09struct vpu_instance *inst =3D priv;
> -=09struct v4l2_m2m_ctx *m2m_ctx =3D inst->v4l2_fh.m2m_ctx;
>  =09int ret;
> =20
> -=09ret =3D set_instance_state(inst, VPU_INST_STATE_STOP);
> -=09if (ret)
> -=09=09return;
> -
>  =09/*
> -=09 * job_abort() runs from the STREAMOFF path and may be called while t=
he
> -=09 * device is runtime suspended. Setting the EOS flag talks to the
> -=09 * firmware (send_firmware_command() accesses VPU registers), so the
> -=09 * device must be resumed first; otherwise the register access faults
> -=09 * with an asynchronous SError.
> +=09 * v4l2_m2m_cancel_job() calls this while the context owns the runnin=
g
> +=09 * job and then sleeps until a finish clears TRANS_RUNNING. Ending th=
e
> +=09 * job from here while device_run() is still executing -- or is about
> +=09 * to be entered, v4l2_m2m_try_run() having set TRANS_RUNNING already=
 --
> +=09 * releases that wait early: try_run() then reads a curr_ctx that is
> +=09 * already NULL, or release() frees the instance under device_run().
> +=09 * So wait for device_run() to return first.
>  =09 */
> -=09pm_runtime_resume_and_get(inst->dev->dev);
> +=09mutex_lock(&inst->run_lock);
> =20
> -=09ret =3D wave5_vpu_dec_set_eos_on_firmware(inst);
> -=09if (ret)
> -=09=09dev_warn(inst->dev->dev,
> -=09=09=09 "Setting EOS for the bitstream, fail: %d\n", ret);
> +=09ret =3D set_instance_state(inst, VPU_INST_STATE_STOP);
> =20
> -=09pm_runtime_put_autosuspend(inst->dev->dev);
> +=09if (!ret) {
> +=09=09/*
> +=09=09 * job_abort() runs from the STREAMOFF path and may be called whil=
e the
> +=09=09 * device is runtime suspended. Setting the EOS flag talks to the
> +=09=09 * firmware (send_firmware_command() accesses VPU registers), so t=
he
> +=09=09 * device must be resumed first; otherwise the register access fau=
lts
> +=09=09 * with an asynchronous SError.
> +=09=09 */
> +=09=09pm_runtime_resume_and_get(inst->dev->dev);
> =20
> -=09v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
> +=09=09ret =3D wave5_vpu_dec_set_eos_on_firmware(inst);
> +=09=09if (ret)
> +=09=09=09dev_warn(inst->dev->dev,
> +=09=09=09=09 "Setting EOS for the bitstream, fail: %d\n", ret);
> +
> +=09=09pm_runtime_put_autosuspend(inst->dev->dev);
> +=09}
> +
> +=09/*
> +=09 * With device_run() out of the way, the job is either already finish=
ed,
> +=09 * still to be run -- device_run() then finds the instance stopped,
> +=09 * issues nothing and finishes it itself -- or held for a DEC_PIC
> +=09 * completion after EOS. Only the last one is left for us: end it now
> +=09 * rather than leave streamoff or release() waiting on that IRQ.
> +=09 */
> +=09wave5_dec_finish_job(inst);
> +=09mutex_unlock(&inst->run_lock);
>  }
> =20
>  static int wave5_vpu_dec_job_ready(void *priv)
> @@ -1920,6 +1964,7 @@ static int wave5_vpu_open_dec(struct file *filp)
> =20
>  =09spin_lock_init(&inst->state_spinlock);
>  =09mutex_init(&inst->feed_lock);
> +=09mutex_init(&inst->run_lock);
>  =09INIT_LIST_HEAD(&inst->avail_src_bufs);
> =20
>  =09inst->codec_info =3D kzalloc_obj(*inst->codec_info);
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/dr=
ivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> index 397da200a9ed..c7e61e2b78eb 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> @@ -286,6 +286,7 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u3=
2 *fail_res)
>  =09wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_task);
> =20
>  =09mutex_destroy(&inst->feed_lock);
> +=09mutex_destroy(&inst->run_lock);
> =20
>  unlock_and_return:
>  =09mutex_unlock(&vpu_dev->hw_lock);
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/dr=
ivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> index 7b08fef58217..2d515c9028a5 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> @@ -826,6 +826,9 @@ struct vpu_instance {
>  =09struct mutex feed_lock; /* lock for feeding bitstream buffers */
>  =09bool queuing_fail; /* if there is the queuing failure */
>  =09bool empty_queue;
> +=09unsigned long job_flags; /* bit 0: a device_run() job is ours to fini=
sh */
> +=09struct mutex run_lock; /* held across device_run(); job_abort() waits=
 on it */
> +=09struct delayed_work unstall_work; /* releases a stale empty_queue par=
k */

This might belong to patch 6.

Nicolas

>  =09struct vpu_buf bitstream_vbuf;
>  =09dma_addr_t last_rd_ptr;
>  =09size_t remaining_consumed_bytes;

--=-GVO2R+Bz5ri09iN1whnj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawjZ5gAKCRDZQZRRKWBy
9OueAQDqpFGgwJ8W1jTtpkk5RN03PhgujXm4WKjOco2NhcddnAD7BoIetzstKYvS
PSBZLG2RjCLJzwQA7eTDLaMOfi1y0wc=
=6eWI
-----END PGP SIGNATURE-----

--=-GVO2R+Bz5ri09iN1whnj--
