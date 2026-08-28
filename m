Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE58F39A04A;
	Fri, 28 Aug 2026 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787905393; cv=none; b=WcU9XB+PK+w0e1Xbx+wzEAq1f6pAPu0HxSIFzPb7JkHQNcpbEXQv9s3Z8ncTtJBFpNdK8Xqe5rZMMHn/iPkydwgfkAZuFjC+MuAXyCkt2AJ13CM0sdcYdzS0JOOvbS3B49LwSUGcx8loKASNpN852JQ3I/CT6TsSVank0uXkYYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787905393; c=relaxed/simple;
	bh=hDydiq7AQMDQDpd+0whVhGG1pczvBtYNIPt4W2hjzK4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=entGZ25cVUxZZvgaHPdRSK0EGa/cMPE7AU36FlWBdiKrCuezKicx0Lj1vDaiuqicdNnbD1WZTINbRXwxzRthjp4eErmJpvUQcWj3ivaAteOB5zCVIozS+Qp+z7HGYSF9vqCtkWZrf7DtOt3nWCdxRBdFuI1eKYAju0sXSeusJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZUjvASJ0; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZUjvASJ0"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hWWbn2kJTzKmTr;
	Fri, 28 Aug 2026 10:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787905381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsmP5wmnG/UQyhwJAqUcew+uGLtul3Yjk3sK/pL/sxc=;
	b=ZUjvASJ0A06DSzNfhieJCepU83N6DnapX+ofTuJtugpd2B/7ZvgnwvKQjEqquhexYHMOT+
	S3cyCdu/gMfdDcVJI3MADuPTwetpDSI0CY1WjpBOWuggv7zyyaSNeu0C+9tBceY88dO8Hx
	shJQUn9RbYYfD1VPTdzuEvy9kyvF2KyJCuL4eq5Z28QS0z2BLo3C74Hy84RvW1TWju46Kd
	O2dLb1C8fH9mBGAHpRMHJLvpDpkk7Qfl0KVL/oFdLwZ4T6v0xNWJB3E/2Qu/bx+OaBnDL3
	ksgulA3doXWxY6utUF+lcrF//Kth3L8pLlcEIZ/9nk2qAj/qC3O6OXc3T3tOdQ==
Date: Fri, 28 Aug 2026 16:22:59 +0800 (CST)
From: Ming Qing <a0yami@mailbox.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Daniel Starke <daniel.starke@siemens.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Message-ID: <2073007787.358333.1787905379172@app.mailbox.org>
In-Reply-To: <2026082810-vastness-detest-6637@gregkh>
References: <20260828031949.18580-1-a0yami@mailbox.org>
 <2026082810-vastness-detest-6637@gregkh>
Subject: Re: [PATCH] tty: n_gsm: pin DLCI during configuration ioctls
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-META: 6ofpc3x46i99rjc9c3yefquruusuc86o
X-MBO-RS-ID: 21c49ce813949b09834


> On 08/28/2026 1:50 PM CST Greg Kroah-Hartman wrote:
> Please have your llm read the email archives for why you shouldn't be
> touching this file at all, UNLESS you have the real hardware and system
> to test it with.
> 
> thanks,
> 
> greg k-h

Thanks for the reminder. 

I'll be more careful with fixes like this in the future.

Best regards,
Qing Ming
