Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794747298;
	b=E2c2dF/YxEXA6kvNcu3BIF5IiLfUeIS0EcWnM12u/DStEA4kQilaFlpgdWwhe0S5DFUH
	 XGaOUgo6bPVRQ8BLgquJmrHFJgi6UcbdZ05VJboYuMDYGJxfdywVvzyjzDPbFrCPYby+1
	 1lhdlRlpUkIQPmtt3VR+EtJbCqkYe0N97gYBYp2peguczNGMiO3jRwHIgK1nhLup61P9Z
	 /l+HjxIrle3CMCOSC08Kb2YzG2imcYXC/6SMbZhbe86wDzRzwEBJ0sNr02XXfok9oprdi
	 N/TK7CgYc4aMSHLKo3JRPENfsO9aZEwf2JufkUaMI9GaGm5pZ6BjQH7fq/gTpiGYMRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794747298;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=AJTKULYseaeK5WjHYtGrkruJIYuQWcLHf4wiRJSayYY=;
	b=UdmJ18/UITpNIqb5z+iZoKvKsYfNZEVVCqm5z6huhkYeVo0DXeHTdXCwBkV7gn4xkCcV
	 HidpKPFbfHazwpzv+l69ZkUKts60cV/rXaRLOSih6yDAvee/25Sbk49ofR38QWfAZvd1k
	 6x9DSgv1woo/5KBosjFg1pVgqdsF5B+hxM3Bxaw4QNmGAJfCSHE+0Co6IFlGtGbk/P/Mw
	 DdkLar0tkSTrw4UbJ/+OzntmFGsITfw6dYpltNE7NfXcVPpp1u/WX1O5nsB/aedcbGMHq
	 K0Q5TfLI9XO5Jp2nrQMYGEdgE4lWHsB199PSMPkzbLXANz3zgx4m9t3IQNqlVy77nWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSIPRigB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F42606A31A;
	Sun, 15 Nov 2026 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSIPRigB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6801F000C4;
	Sun, 15 Nov 2026 12:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794747298;
	bh=AJTKULYseaeK5WjHYtGrkruJIYuQWcLHf4wiRJSayYY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gSIPRigBwIctPck5wIv4+u3hlMzO9GbAF+hN46/IM8ZR/4VJvencCFeC7m39EKC+x
	 1OeFidqcun9/TmXmsYVHvoPET+7UA+ch7CizWKYVKfbfA6jbs1rL0+alcaUBbhIF/k
	 Q8n+85uJ/E1wp0wy/Seaa5T7g/dE6VPfMu66sZZDLpQUKvLCVIULhEmedbTfAZbsf+
	 hOsaG54OLjJ10OqiWsNvWPj3hEttquU86bcNCuegwZfNoU8d85wMVSwSRRATnrStwc
	 DKw663nyW9jjXuOz5I8FLtA7lSa01HlYlulIxCETbfzUHMhaZ2J+BJrbATVGNB/tF4
	 Tg5ynOFW+ga4g==
Message-ID: <c81473c3-e735-44ba-b9b3-ef71a206e4c9@kernel.org>
Date: Sun, 15 Nov 2026 12:54:51 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: Fix out-of-bounds read in timestamp metadata
 fallback
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <MHYjgQwKyl4g6PykXAKsc_qby-VHmaZ8ZyKEoTM1Fpmve-Cg_dUJaQT0a2MReqplHxr4JLS7xunPQ6qB5AlxVg==@protonmail.internalid>
 <20261017-fix-oob-tss-v1-1-fb86f4cabf65@oss.qualcomm.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <20261017-fix-oob-tss-v1-1-fb86f4cabf65@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2026 04:25, Vishnu Reddy wrote:
> inst->tss[] has VIDEO_MAX_FRAME (32) entries, so valid indexes are 0
> through 31. iris_set_ts_metadata() writes at metadata_idx and then
> increments it. After the 32nd input buffer, metadata_idx is 32 until
> the next input buffer is queued.
> 
> If iris_get_ts_metadata() finds no matching timestamp in that window,
> its fallback reads inst->tss[32], one entry past the end of the array.
> UBSAN (Undefined Behavior Sanity Checker) reports this as an
> array-index-out-of-bounds error.
> 
> Use the last written entry, metadata_idx - 1, in the fallback instead.
> Fall back to slot 0 if nothing has been written yet. Even if stream off
> and stream on happen multiple times on the same session, the fallback
> always uses the latest metadata received.
> 
> Fixes: 17f2a485ca67 ("media: iris: implement vb2 ops for buf_queue and firmware response")
> Cc:stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_buffer.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
> index eb8de60c1177f..31cba99a665c1 100644
> --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> @@ -865,9 +865,11 @@ static void iris_get_ts_metadata(struct iris_inst *inst, u64 timestamp_ns,
>   		return;
>   	}
> 
> +	i = inst->metadata_idx ? inst->metadata_idx - 1 : 0;
> +
>   	vbuf->flags &= ~mask;
> -	vbuf->flags |= inst->tss[inst->metadata_idx].flags;
> -	vbuf->timecode = inst->tss[inst->metadata_idx].tc;
> +	vbuf->flags |= inst->tss[i].flags;
> +	vbuf->timecode = inst->tss[i].tc;
>   }
> 
>   int iris_vb2_buffer_done(struct iris_inst *inst, struct iris_buffer *buf)
> 
> ---
> base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
> change-id: 20261013-fix-oob-tss-7d317d612cf0
> 
> Best regards,
> --
> Vishnu Reddy<busanna.reddy@oss.qualcomm.com>

Just control the variable where it is owned/assigned - the index should 
never run outside of bounds - dealing with that out-of-bounds is a fixup 
that shouldn't have to be done.

Don't let the index overrun at all. That way the next function that 
reads the index, doesn't have to know or care that the index might run.

[0] % git diff
diff --git a/drivers/media/platform/qcom/iris/iris_common.c 
b/drivers/media/platform/qcom/iris/iris_common.c
index 25836561bcf3e..b2b9349c38ea9 100644
--- a/drivers/media/platform/qcom/iris/iris_common.c
+++ b/drivers/media/platform/qcom/iris/iris_common.c
@@ -33,9 +33,6 @@ void iris_set_ts_metadata(struct iris_inst *inst, 
struct vb2_v4l2_buffer *vbuf)
         struct vb2_buffer *vb = &vbuf->vb2_buf;
         u64 ts_us = vb->timestamp;

-       if (inst->metadata_idx >= ARRAY_SIZE(inst->tss))
-               inst->metadata_idx = 0;
-
         do_div(ts_us, NSEC_PER_USEC);

         inst->tss[inst->metadata_idx].flags = vbuf->flags & mask;
@@ -43,7 +40,10 @@ void iris_set_ts_metadata(struct iris_inst *inst, 
struct vb2_v4l2_buffer *vbuf)
         inst->tss[inst->metadata_idx].ts_us = ts_us;
         inst->tss[inst->metadata_idx].ts_ns = vb->timestamp;

-       inst->metadata_idx++;
+       if (inst->metadata_idx + 1 >= ARRAY_SIZE(inst->tss))
+               inst->metadata_idx = 0;
+       else
+               inst->metadata_idx++;
  }

  int iris_process_streamon_input(struct iris_inst *inst)

There should exist no window in time where the index is invalid.

---
bod
