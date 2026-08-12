Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4192B3AE6E2;
	Wed, 12 Aug 2026 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522115; cv=none; b=gH6JcsD+UvI5nL+eZnKKJ6XR2GUbbUdw+TOjJAVPV32V3BIi2k4xc47Icuga9N8wAzltd6GdpwuQuJzf/9NVsurouh6l/PEoArIxAEdsoUwxZfF40GTd6uy20eoCSKTvfvj9Per4wrVDjAcpIi4U41UToLwuvO7hEfY8Fdzs9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522115; c=relaxed/simple;
	bh=Tb4+pN4Co4wjZEX1o5/C5gLdRmo7Y8PIdHLLNpWEUMg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bXdQ7GbY9BXNMNAwLz/kI9oycUN4L2BYZLC9dWZ1xmuG5cBZ0VPJHqobevuUGtbiVpNjdoU+rkshsSADltsdHCthq7p52sRHjR4ip+ZLP1tegwu5BjTwirlLhZ8CGKpzJXdzCbt6Sc/jqtUO3awMtnnaIlkwVE41fD0mIBJVu0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmhE99h2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmhE99h2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FE31F000E9;
	Wed, 12 Aug 2026 08:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786522114;
	bh=2N4dEcZvp9V+FiV8Y6xckLuMfyi88p7lnAUfO7wp0cg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KmhE99h27VRrUD1HOZNJu++1tOGlqnew54odGLYC7MATCMhBxXvs2oilLU7OXxBu+
	 1bw23kKB/PBnIJkJuXRmib7jSgiWffsaxMbtzbV80pnit4bUSILkctbUOjyXXi4iEu
	 eAuBh939gedLiG9swAyZUl8UU5lG8JDFfG/Vv4wzO05jB/pw1VTfkVhf5Q80we5IXZ
	 UvddItY6DbEE6T1q/yNxyYBgesHQAKgH85BwxBeD/YnnvxOjpcOxxRsgCycfQVb5RX
	 NIVnQzUAu/lXtLMkM+sEfYuuWw5fuYdQ/OEwQo4vvryZPyYSupKOZ5HDAhiunuhiWP
	 GlPqc3kGiPxcw==
From: Lee Jones <lee@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee@kernel.org>, 
 Ali Ahmet Memis <ali@iusegentoo.com>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260802135307.31380-1-ali@iusegentoo.com>
References: <20260802135307.31380-1-ali@iusegentoo.com>
Subject: Re: (subset) [PATCH v2] mfd: qnap-mcu: keep the reply buffer alive
 past a command timeout
Message-Id: <178652211278.1293856.6446175346391475139.b4-ty@b4>
Date: Wed, 12 Aug 2026 09:08:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Sun, 02 Aug 2026 13:53:07 +0000, Ali Ahmet Memis wrote:
> qnap_mcu_exec() publishes an on-stack buffer to the receive path:
> 
> 	unsigned char rx[QNAP_MCU_RX_BUFFER_SIZE];
> 	...
> 	reply->data = rx;
> 	reply->length = length;
> 
> [...]

Applied, thanks!

[1/1] mfd: qnap-mcu: keep the reply buffer alive past a command timeout
      commit: 47504742cea7878ebd1bf1491bbed923df6b90b1

--
Lee Jones [李琼斯]

