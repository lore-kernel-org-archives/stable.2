Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120702;
	b=HEvM0l9ey0hWhDgn24fFblkCFzSBd6m8IxJ7aRIrLQbXqmpUJTq2uZ+PnWZixDcB7Xef
	 Obxe7Z9blcvyrnxWTzCCd6rU8E7P65GV6CCqT4Whir11wJpURxwrhf+dndTOHLl9PM8mZ
	 6VZRswGMV55B4JNcm4dE9ew1H8RkAsdnjJg6rDaAVArJwZyDPp3H/FBLEVgC3UvTYz13l
	 NHk4oI91By/EbI2L7XGWEvu39N5ud58Do/qfIwZoATDix4G812Ih8PJfYQtLB/Q76EWs4
	 rLEnF56P93lsE0cJvHuqD4F55GVsMtdgVDUBfwa5W90C7LEXNWFzBhw6GOR75ERQtpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120702;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=Br8FHiBcwqHjN+vxoh1IJLwh7MvGazjlS3qbm/JbPJo=;
	b=QRj2dCB99CLmCZLE3DEhnWPfEkd47heVl9RBo5+vTnbG35yn1S7ISmVJVRdy8FgY0+Fd
	 BfdPkx6MthXj0aKA2mQyW9y5gclY/6F0JjiL8SlDSGr9imT6SmLhjH5Tg/9oAt8/bFYER
	 D2lqYtsbde+i3eaU624kWbCJawg6v5nJnrGea8NdXQaiVVuol05BWNFk21bTZJ+MKgYdc
	 576RjwQONQHJ+Xqs3LIpiIFZ7yESe4CnI7D878AHkR5Y3cmbxlHrdW+vL0GneWKIywbHQ
	 eusOUb8ZyyMM6SXdRVLLEEaDKg1cc53e6Lb9I1+D4iVssuUJtCo2G+aFsUdECnQPFKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBF7qrav;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B302606A901;
	Thu, 19 Nov 2026 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBF7qrav
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67591F000C0;
	Thu, 19 Nov 2026 20:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795120702;
	bh=Br8FHiBcwqHjN+vxoh1IJLwh7MvGazjlS3qbm/JbPJo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ZBF7qravv3cuygNW66tizHLyLBqJzZdJQxgzFmZTjN8pIbH8ZHdoi0bNG6d0qN90N
	 6aSteIBoTHU+K87npoT7jiUuvAV2RYLYPWvNAXxb/c6dlrwFkj6+4EMtOgQHiGEQh1
	 IbQC86Uf8BGC840e5HzM7wCl24n+ICG2H1d/ICgfIiVMKZxupw2y/YKyIt+s2x1yLl
	 JrhgbsyRCClSNUaU6AysEs4GW1V4hMyWIHv+A+t7O17OMMN5M2rgwEqXzeemJFurUk
	 tqKbz4IsLxngBTRzImWchs0DOrhiN3TIFRbO0mxeK27bEU+XbT+9szmZuXruHZHH4S
	 T6PdImd13HE2g==
Date: Thu, 19 Nov 2026 21:38:19 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
cc: Jason Gerecke <killertofu@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
    Jason Gerecke <jason.gerecke@wacom.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] HID: wacom: avoid divide exception in dropped-packet
 calculation
In-Reply-To: <20261106120405.169399-1-qwe.aldo@gmail.com>
Message-ID: <7s6q7s9r-4s54-4599-p258-165oo57pp42o@xreary.bet>
References: <CANRwn3RYhEu0g9Lx+Vg=Uy8V7BWWz-jWV9d7UVuyRK-MGdbHOA@mail.gmail.com> <20261106120405.169399-1-qwe.aldo@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 6 Nov 2026, Aldo Ariel Panzardo wrote:

> The dropped-packet calculation uses a modulo against sequence_size
> (logical_maximum - logical_minimum + 1).  When a HID descriptor
> declares a sequence field whose logical range spans all 32-bit
> values, sequence_size wraps to zero and the modulo triggers a
> divide exception.
> 
> Replace the division-based calculation with a branch that computes
> the forward distance through the sequence range directly, as
> suggested by Jason Gerecke.  This keeps the existing int types and
> avoids the divide-by-zero without any 64-bit arithmetic.
> 
> Fixes: 359673ea3a20 ("HID: wacom: Support sequence numbers smaller than 16-bit")
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gerecke <jason.gerecke@wacom.com>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> 
> Changes in v4:
> - Replace s64 arithmetic with a branch-based helper that computes
>   the forward wrapped distance directly, as suggested by Jason Gerecke.
>   Keeps sequence_number as int; no type changes needed.

Applied to hid.git#for-7.4/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

