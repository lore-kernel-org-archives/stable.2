Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697687;
	b=tZa0uS3JmJ90bVtmiEKfHhSYsJXsPR9KWFptRS+Shn+7nEAUm1uhIyhLtkWYgdQ6I7Ry
	 oWUP1FoT6zksPjHQWjXfGjNQOhrIUk6zCRh7ynkzkZJyC0Xkd1BassUCPabGjcOPYlFl1
	 p96Byscp25WB/+/WBs2nrgLJObVMw7LrIMdiobn9uUF3cGXxnupyH1HAf22ok4kxzpa7m
	 BwoYMRaberZrCB/BM2fFnM3mvGmR0HjIMFbzxnDNnfQXhDjm2HuthVRnuHSchAYj1/Dr0
	 LjPu8GJEC2R1yaqTzzHS1KIluxIDDPXGK41rV+PZZH98byek13P+x3wuYvzgqV5yFIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697687;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8gvrtFNaPF85MZnIqWG775YGSTQ1q4Yj1NpyoCXwkzo=;
	b=wZI6ywSMqWkCqXs0O71BitGyj99HMoeP7OoCQUyLEgsE7dcZFPwoFMS0TSfEpqYGfRTB
	 7WqnYtJfVyxBBDNzmvmcwPEc+yBemBThbx0KBme/hhaB34OFKKx/qkDVnCMMbeD5UFDgU
	 mHdtdLOZnud1kQF3+AimOb7Nu6plzAAJRaDnifLb09OTQbUkTBfl3rvoTgvMXuNKOC6pm
	 q10IKzONDAb3/2wUpu3hQcTSrPrRwE9p9K4nYFewfvXS6R9dxkS1x5dq+M3qveAdrNBOZ
	 rPbGl2KWOEkjBcK9RKJuwEqgUvDYUio8v7ytz1mTyiMccwRrel8uVfq/sGDxC7pjILQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvkWm0DS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D3C606D802;
	Tue,  3 Nov 2026 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvkWm0DS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D670C1F00A16;
	Tue,  3 Nov 2026 09:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793697687;
	bh=8gvrtFNaPF85MZnIqWG775YGSTQ1q4Yj1NpyoCXwkzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dvkWm0DSi6XmsJWdmyTJtm+nVGXM0H78lqGG2zM3ZREVdxtR72ptzmW5hja5TBBpg
	 acaXrR+fECf4WjuTaqgZMX0Jm7ll39uDgtqdqQE4zXms4Nltc2XbGygFuG72yMgWVC
	 dD6w5h5wqhEtv/r9w7tHj93PqIkr7JzncW5srFKmSqrnpNLDz5WWpVKfEdW386REGj
	 G5feJqXR+oZyfTEy0yL7stNh7MBSJF7T0TFubl7keW8Do/pDOvyUqOLFnk9ufAVGcR
	 KGylFueE8W4tDwAW/xnNy+SvbHuxZh/fm6N1reApBXGIc7ZZMSpTI+PY+G2AS2anAE
	 mx6Kds5LXs9QQ==
Date: Tue, 3 Nov 2026 10:21:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com, 
	yunfei.dong@mediatek.com, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: mediatek: vcodec: Free encoder controls when
 setup fails
Message-ID: <20261103-authentic-manipulative-shrew-ea455b@quoll>
References: <20261103083533.1176842-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103083533.1176842-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 08:35:33 +0000, Wentao Liang wrote:
> mtk_vcodec_enc_ctrls_setup() can fail after creating some controls. On
> that error, fops_vcodec_open() jumps past the control handler cleanup and
> frees the context, leaking the handler's controls and allocation.
> 
> Use the same control handler cleanup as the later m2m context creation
> failure, and remove the now-unused label. No m2m context is released on
> this path because its initialization has not been attempted yet.
> 
> Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Encoder Driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  .../platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c      | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




