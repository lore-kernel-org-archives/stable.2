Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7635137CD2F
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787742788; cv=pass; b=Os59fRNBU9bUMLSyjgne8Vp17gY94pHTmEzvAsrHosUoG15oxrHexIJAxhVTzaytT9DXtfccJXXA7fm0eGyYE7GfA7Kk8VOdLddqaI/KJmMo2vXWnUq1UNSDMEUYp5E9//Z2onD3zFSqJDWAnITtpoCAGhZZx3RE/NdKpO3qmOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787742788; c=relaxed/simple;
	bh=qxK0YDq758BFaqD9s7iCBATXt0a1M5kbbbBPljI+lWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEfVRNl0s2VBkTb8gVwhIJAkvT6LP8m4GuO7P1/50xLfWkZ+PCEVK+ykTdtGreiTBB2Fb8C1TO4fAC5cPR0QJP4EO92vNqDAuApn8didfUdhukGnZxry+sr4ndTEET7UC/bSbIr9+z+321iHUo6Wyjugc1tImL9WShcJtLBSGgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=H4f+dczu; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="H4f+dczu"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so7534046d6.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 04:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787742774; cv=none;
        d=google.com; s=arc-20260327;
        b=L/asdBVIVCaLx9tTEwIAGPb7/3jkenjg3Id6sATvfbC6BbKO+TSgppQRY5kG6gfJNk
         qidPfv28k8MyIhZyGiNAFKUjCK5popMTJvEovJ7Oj80giC/ErWEQQfrkbV4H8ZPIK5Jg
         ZUakjQ0fg6RrSbF9QwU/2lDL3Q99LY+0Amtsp47bnILretushC8XmIFdQZPwaZFR6+FT
         h3PX8s4ElQ8mlC+Rw3P+Ly9h/WHpka4AyZNAmFhqRN0cE3Ux6nOuoG+2dIrYWbEUvHZO
         /5XR9MeA0zN8HKCyYQcUeu1Ub+ZpUu37+d+YYZWvvirm5+Ng9hsP58vqsI/WbDeBaCkB
         6G+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qxK0YDq758BFaqD9s7iCBATXt0a1M5kbbbBPljI+lWU=;
        fh=lKug6L1xXMNE5FhkZ64rV1JjN2wtgA6O2P8nxeZyXmU=;
        b=myKXzHthuxDBK+X2kCgaxcODX2MtR/Fx/iSH/Ciyj/a6nDcwqzx/qy17XecHWSct4I
         fvHbcS/bVynoRUu78WV5+1GYs+G9QxFmlH5aSDWgOmPOFYdvzpOmVi2wEi7hll08tkvd
         3h4ulmMzF2aazLOIiUVg905oUVEjJYiEhPjMp4v2ymPM0bWuGD2VfQY4INgKwbrzkyKS
         8jLlwlfT64q0+eQ5M/GI6fc6ZTDoXaG1AAJSn0m3IsomhQMKH/W//51xJ5p2R7TT9W88
         DKhNZ3GRhOnW1hCAZRzu9/2Rl71CKqPuRNsr1ecUq62kIbmRyudhUZnxzLNk70PKmTBT
         QuVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787742774; x=1788347574; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qxK0YDq758BFaqD9s7iCBATXt0a1M5kbbbBPljI+lWU=;
        b=H4f+dczuDbl28JvwMiXOhV72AQCRPJpV76cvfKkAm7M1ejMGDST2Hmtfxg+28OULou
         YdyffQth7lTL7J6UeeNBVQ3hlswFlJYI11oakfsTdcdY49v1BjS2WZvVV8CNnSBF3ISM
         3HWrNXDrOZ8qYSGiZ60UCY9vh/bAfE5KtIm1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787742774; x=1788347574;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qxK0YDq758BFaqD9s7iCBATXt0a1M5kbbbBPljI+lWU=;
        b=KFcM6tTRnAS59z7jVTNFeHqqVwz5WssPoeyOhJtWND5L9f0ymrrFlZTuQpNNjKziVh
         4dX9cBDJOnizZs8ykPrrmdbin9OfQr925waDlHiQHznSMSNq2Gv5+A+TYwLtx0j0CsXp
         i/3vnfE4r+4iXn83JdmGGDDCM0GByVMsfst+ywy+0+tISQ3TXsu11wJTjj27Qrn/xvkS
         /GLIVocqYf+tOAWIJNb/P7r3Ls2hqBMlgjm3NNpN75FA31jwoFpHvlGjs9oI+MO0bqM9
         COejmCwaIHxb9VDdD3vtdt0zj+sGQmSKJGyvtwg3zJKLfduAXFSN5X3vDszFbifrvs2U
         3A5g==
X-Forwarded-Encrypted: i=1; AHgh+RrRB40hf8qsUIGlPVIREiDFLXYxxd6SEBlDE4wtTLJq9yHxJQJvlkbZL8zl7uU+vbzPlkjSuXc=@vger.kernel.org
X-Gm-Message-State: AFuF++mAV/Afmf4A0dGdfNRaXvAuiDXUJK0aNNQBWd54M3RVfDRuiJ08
	iMD/uN7g7CyU3nV/V8eO16kVpv0xuG5sFxo81SQn18VX7f1bvTOj1gYxGBbeJEZphulUbBWGpjm
	ELR0h/1en/T4RmX55n81mtlWv6Vfb6oBa6IeCWA+KkQ==
X-Gm-Gg: AR+sD1284GmCb4/+1mGzd3WattDmdKaS/93aiDSLsQRYu/W/CoclFDLQohn11xuv79v
	fM7i0R4WJkRKIHQnb8xpmAXoKEqDHsyS78KQTsBxHfGAyj0FlnrRUyB6YDeEilL5KTjFTwXQbP4
	J599JCkCAbNxKgJat+O+uB1RgsN7vsosQMt6LQdlhzwq7LAbtOD/9kCOw1ONU3AX+dM/nDBSoq4
	5tyfOTv1ONIgv3X8190p4hxq02Yx02oNP70mtJmaqccRum6qj0x94G7JJzGzlNYZraqKOvZXeZp
	ttfcmHYSi9IZJtAdLtzm/z7FNtPvLoNrrFZAuihM9gZp8hB/fJW6YF3DdgdYQaDmCtb+iLvC63U
	hm14=
X-Received: by 2002:a05:622a:598c:b0:51a:89db:95a4 with SMTP id
 d75a77b69052e-52e42235c73mr56562851cf.6.1787742774296; Wed, 26 Aug 2026
 04:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717142932.71778-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20260717142932.71778-1-jefflexu@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 26 Aug 2026 13:12:41 +0200
X-Gm-Features: AcwNN1Vo_Xquz6yQXC0Ul5m-lrRUzwHF_AGPWQxv0w2EORhRsYCELfowq71-yN0
Message-ID: <CAJfpegs61t4v1OUp3t_LktaVM=yVj0W2bgEQ+a5EVKU4MNyCwg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: don't bump attr_version for async direct read completion
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	horst@birthelmer.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jul 2026 at 16:29, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> Fix this by only bumping attr_version for write completions, consistent
> with the synchronous DIO write path (fuse_write_update_attr) and the
> cached write path.

Sorry for the delay, seem to have fallen through the cracks.

Applied, thanks.

Miklos
