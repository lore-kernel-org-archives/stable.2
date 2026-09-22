Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489A54915A1
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 05:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055866; cv=pass; b=n2q3pyZt0h5/tJUEsvBCrkkDK4DEr0Axb0vaprCrDxgrnZ/Ct5ydH2w8bLGlvUAHRYm7rlYw7jekUKv0ZNBl38c7OIlIKB6IvMoXxSmhu//1pMVfUWqu3347Imm9RIxCfDQwOA9fQ+fW76uGFRHyKCRclly+nJZ8c5jOospOff0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055866; c=relaxed/simple;
	bh=mVQSIA+KZumLgnewVGIvAtxnjvVRKy38ae4smjKb/as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li5jOSp3dw7QAMxkPzxdsqUJ1qSYrUeDhSEyQKz6lwDTfWaPgFVLrM0RRDkLg59k/0Z0KcyCkY0jKySo+eNd4JdeLKYMnPw3/qTiBqp9fgG4SNqeoN2GBEwFGjH+nWB3SnR9PXpOyzBgTGGOXkIZvh8MP4Q9fy9SMn8jFAXTkAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alh4MT4/; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alh4MT4/"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcdso31325857b3.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 22:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790055863; cv=none;
        d=google.com; s=arc-20260327;
        b=X40tVywC7JNLOjlX7anvDeKV+rSLxn0UTtdYxYwI+FFcMZ2gk3+StBDMIIDdT6FzCO
         +FeJ1TDMuR5ZENOxGy1VxKfg7Bn6RJKOsSDrqg9l5MhFRJqwinPRUjE6BZ4L1rdTJXZr
         IZuaSqmjYC9tZG2rCog44HC8z4UT4PMDfKaQDIMWYre+W2H91tjETxY9nSvvfCntner5
         IWLrh6k8HQCgy4QlbOvnyoKDj0Cap5dOlGqvn3WiQKdPriugAxq7PgzoYXBPjJGRXxn+
         +nvLsfYEGPq+QSazMo+82eMk+KhCpP010luwFUmYaP4j0IYRUZ6kPvl295kvaCYoGTG3
         I9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mVQSIA+KZumLgnewVGIvAtxnjvVRKy38ae4smjKb/as=;
        fh=QbA4yadAsYoB9X2riTTZiscFP3IoG4F4zebw9J1mS5Q=;
        b=l+q/j4GgV9PRIbAtLo1WDgTkHZXNWrKjUD2VZribwB5GrNZwrrYJ4Xr0LFE8Hs/8ht
         67iVO479MKHH0C+1goowpd4qWaOl+7CITzT2U/NiGJhmADdGIYsBnjmMFq6RfMEm88NJ
         GY0U5TdSdlNgHjoZRSTBOEIGOpMSUUIMDs+s7tiN6dGds+4mopfzAyKGkq4Y6jy+d7cA
         qAAg89Ol0h5stBbuGxS3Pngyc2echTYMyd6F9OpRZyeK+3GIOkqRk4014nKqQPYeLE38
         moqr+pxfGXptuxRBtX1EbK7gAkgZMOchxwfbcznfsKxdo73Ll59hPLRF0cu9aM7jLrxk
         BGTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790055863; x=1790660663; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mVQSIA+KZumLgnewVGIvAtxnjvVRKy38ae4smjKb/as=;
        b=alh4MT4/RcYVDgAdFFUjukbEVgDAlTB0HsQ5/unsb6GgxfVrJT65Wa03qbbMYXIbrm
         aPXvMcxxZgfEa0GXKv85LwX9nFYVIWUPpOvdQLabI217ebezb6sfKev9T7HLX7+6xT1U
         AyHVFFvp6aMd//VK42Phzp5SQZaw1+bPRGZrWId5/Je9M2cmGSow3c4YZDK1i/eg2WN3
         5Z2+VyuTo+9kkn0LHgYZDoNXTIcXpKJoNGnHKtQX5MHNV8R6koILCotIyeCyPZWzTzMD
         pgYqh7FzsBiWRdrG3hLKSvUgImzUFO6Uskx+mhEr2HBz7kps7ktH4owtTqqh+8HkF6mb
         x/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055863; x=1790660663;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mVQSIA+KZumLgnewVGIvAtxnjvVRKy38ae4smjKb/as=;
        b=LicZn+8iFp3NYRSNlPq5o8T+XaZRC5xn7x4BQfPhkwEUdLYWg7niLgxYi9fS2CYzkU
         9phjtS381Rm+NRawNGZYnkIbL/bGc5+abO4VJ921VHLzlokTAJUMh/b5Jnx08xFEz7s+
         9pc+nE0r1VMgh4qIkWkECUXBVW0ZdClJVP93ovZjKvHjDlGtsZKqwwbLl+b2alc4YsdM
         V9VK8/yufDRX9lYataSTMrNOHrai+rEfb7hi85wc78lAItZSz74wMH+vveIGgcVvRfa+
         lGo8PIRpyW7LfeOImHG+kPra/qHW3bFpWL0RCDEaJlshzvPMmeqpmquEIqgOu3j+zIYn
         5nLg==
X-Forwarded-Encrypted: i=1; AKwUvBwht77EYS4NOVqTjtun9UMsGtJHaiOQnjcjS6SZ6y22ZjdTtgOIddrfMQDZSvAbY1Pmp0Pxrv8=@vger.kernel.org
X-Gm-Message-State: AFuF++nO5SXKFruf2soGakUzpTq5oO52i5ojHlpiODUSUP6acN8LSsA3
	3CpfRVreWRNE3V+klrVaDqta+BdEeno4uuPzmF+Hzb5buLSNqZb7BUrKpM79RHAuDMQRfsMkxdR
	y7dVINlQhGZES8uKwwA4iPbUIrviS7CM=
X-Gm-Gg: AYBFou2dZuJKA6dWtQEP56aLOXYMA+kriZL4jhwdhK9ZofwSefVZERqNkbHSEGujaRH
	j5gO3JgO62BorGrLY4qMIHklZPwkwYsB6gJhU44ntRPHS5CikRYMg2LHICJO8XV0GqzpKMpPVE9
	0J+XYzlRvZD6ixwTAR9wKSUrLC+sBtCeA7Lqe+MG6cgg6oUx76bqhrWUj/1xl19vTfyo5v+QB9m
	BK3EH9CI4RaJmksHvagQSL+8NAU4dGSrn0yllIBlzvZavrGioYUQtYB40uGzS6K/NWbMnYDriLV
	KpeTfqD35xb/iYyrueocvlYsgplUJ16rhrOWFqdAiVeyGSoCjbw7zZg=
X-Received: by 2002:a05:690e:140a:b0:671:70d1:d6e9 with SMTP id
 956f58d0204a3-6717fe6484amr3963390d50.91.1790055863048; Mon, 21 Sep 2026
 22:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922054116.416333-1-oss.patchbox@gmail.com>
In-Reply-To: <20260922054116.416333-1-oss.patchbox@gmail.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Tue, 22 Sep 2026 01:44:11 -0400
X-Gm-Features: AcwNN1X4U-FOuecLC7XSWshGXMtdfg5aLnegDD7bITFGtDrk_TB67QveNxFm1nE
Message-ID: <CAGG=RgCA4kAbx39LuSRiKu1sx2CbTEAhZH1bKNCxPn5i1m=x+Q@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/virtio: Reset device before deleting virtqueues
 on probe failure
To: Jean-Philippe Brucker <jpb@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, virtualization@lists.linux.dev, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sept 2026 at 01:41, Yuho Choi <oss.patchbox@gmail.com> wrote:
> 2.43.0

Please disregard this patch/thread. It was sent inadvertently due to a
duplicate submission.
I apologize for the noise.
