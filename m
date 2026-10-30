Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393658;
	b=CinvUVXxA6P5XFFOcjpiVOCvdL3GCOfT5BUATgDbLsxluze59f1QkbIwjw3AMWKHaA3b
	 m/oLbFaeVr1cS2/kVafYZ3E4KTKMRmB5wa/Tt8PmNA7q5Q8StKj8PP/Il+Td15mz9u4OW
	 ygg1sSI/1A01W3vN0M15kwEHZUEisCc/Q4mA+q8kohLhlesU3cDsJ24jZv2Q8JhCIfif4
	 ZwGoDzekFI6GnnHmjcNnBzc8xpyfVGl9AuZAWVB/pMAxhx2GyOzbPfII8OPJzd2pPbfp7
	 UpS7AjcFWLIKHGgEOqsTaYPV97ZsvIZwOrcidE6aBoYRfqznWUsSC7CVsalXV44Wd8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393658;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pM1yqaDWOBHq37ytMG7JiHq3JKjVE2Aj9gS6TBKxTaM=;
	b=q86dauzQ7wqSnlVmp4WYSSS8sP1PorERstPHJbVnKrRw8AlH9InYXunvZDc2n3a+YPvD
	 pcDe8mdmqHUiE9m0lqnu4X7Lk1Nf9pjnkugZ8moQKxjF16EJRzvAfQTFOVOcgY1eWbY5J
	 vFldEjxvK5h0errGlJEFH6PZCk+ejXzMgOdM0lLAV0PWsx3IRL8Ksc1HLkTB7++iL0hZF
	 8laPgOq9invobWTaP7osqXR18VFmbUeXv93hVRw6Ur2+rZzeCktB0QKDdSa1Jy0G12N6T
	 63HUDtnTB8YSmJx8jmxCYkTqefVIYgWgJ3oUXWwoZveLFXJpeth6sGV0XnKxoRbnl2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGFb8Gi9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F374606A32A;
	Fri, 30 Oct 2026 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGFb8Gi9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1851F0093A;
	Fri, 30 Oct 2026 20:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793393658;
	bh=pM1yqaDWOBHq37ytMG7JiHq3JKjVE2Aj9gS6TBKxTaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SGFb8Gi94WniVAS9M4zBrDgLEk323/Ju0+iNThKWi+XoEczmZD1S70hxTEmUj4Qcp
	 hKlYrsro0cJWQUvTGopgXvk1pfvx652y3Ly4vDiX+WrxkPwJ3VrlnWO5x+k0xrQjkN
	 OpyBVr/ElgNKmOo2nl+8etJwLwxHtF/P6E2R0l5BLJwXNSjrRjNTijhhwcHr8RszGj
	 WLvc65go7tmKIGsX7oiGp75gYlKCA5z7PTsNApifZCalbU9IVORfsyb3PPS+LxMU4l
	 19JNL0T1SsQrc/6T6nQIsy2TJX29zZssEtYyq0vwmWE0GohXMTUzs6iohORQkgUq7T
	 AwaIyfVd3sg4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	seanjc@google.com,
	pbonzini@redhat.com,
	kvm@vger.kernel.org,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 6.18.y 0/3] Backport nested EPT violation GVA bit fix
Date: Fri, 30 Oct 2026 16:54:08 -0400
Message-ID: <2026-10-30-1-daily-reply-0005-kvm-nested-ept-gva-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030103643.573356-1-doebel@amazon.de>
References: <20261030103643.573356-1-doebel@amazon.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Backport of commit 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT
> violation GVA_IS_VALID/GVA_TRANSLATED bits") to 6.18.y, with its two
> dependencies.

KVM x86 opts out of stable by default (Documentation/process/maintainer-kvm-x86.rst),
and none of the three commits carries Cc: stable or a Fixes: tag.

Bjoern, could you get Sean or Paolo to ack this series (and the matching
6.12.y one) on the thread? I will pick both up once they have.

-- 
Thanks,
Sasha
