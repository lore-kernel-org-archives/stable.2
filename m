Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784589;
	b=KOI2uLacSRRZ1R3yKFp2K8PfxdgBWd+YBq/mjdnlIvUiwhjHw8oCQA1agjo1JPC3UN2c
	 Hjm1mdzs0ttlkN2GYzxlpLyeluTpzzKFsntdB2CFvvEAXCB/gCilk/JfDQpB8TtTnXB62
	 pdvgrpGlCxikIoSykVbIJHeAG2uZZVhqkoDHqIuqJXsej7jEqwaD8FicLYgJL4lsYUAR3
	 z1bHEOCa21bt93jRcOuOK9bjTweg4d6MDxejGrvBcyL3Ayt30AsnSfyuLdnS4qm/d9SvD
	 Tns8dqSkqEE20F/y3Nlp2KoEkjawATRDG6v7h3xvm1tLLTajKr1i+FzIM59G90YbfWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784589;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=LeOiLhcf1q+p6at9rZXmc8rKAqsk6n/O5F6TnwP4dPM=;
	b=MjR1b+GP91hKfvx18jb8sUldhwMJchsMo1dfyKNkU+aUCCm6At3RaH7OYAx8g0rrGE2z
	 3yx7iiibVTcP6/PqejmrsTHvipO8XFYUCAwFRGFUssmSBUMFTpH11aZj4T1j8jlUMrxVM
	 Qf+tumfSsfeI9vTsQJHkC4XOFzUr0XaVvGnVQfYhVFPmJWA7pqN8I692JBJNo4krT1ipR
	 T7BjxS8YgADBQLHKsz/xKh9WPKieXB8BCz9kKeqYkbj7fj+d+kp7mhR66oXtjp8+jnYfc
	 cLe3E5Le2yUV4KJTRZQuB13gMOzIL9finp7kzQmCHRTNNag50wwGbLoNdJLMCJRU0oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986F0606A32C;
	Sun, 15 Nov 2026 23:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7131F000C8;
	Sun, 15 Nov 2026 23:16:29 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 7DAE9181BF9; Mon, 16 Nov 2026 00:16:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hungyu Lin <dennylin0707@gmail.com>
Cc: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261113221732.97506-1-dennylin0707@gmail.com>
References: <20261113221732.97506-1-dennylin0707@gmail.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: return charge threshold
 write errors
Message-Id: <179478458749.205616.9260603997709976458.b4-ty@b4>
Date: Mon, 16 Nov 2026 00:16:27 +0100
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
X-Mailer: b4 0.16.0


On Fri, 13 Nov 2026 22:17:32 +0000, Hungyu Lin wrote:
> Both charge threshold setters return success even when
> qcom_battmgr_set_charge_control() fails. If the PMIC GLINK transport
> returns an error or the firmware does not reply in time, the sysfs write
> still reports that it consumed the input while the cached thresholds
> retain their previous values.
> 
> Return the request status from both setters so userspace can detect the
> failed write.
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_battmgr: return charge threshold write errors
      commit: ffce9bb777f28733e981928fb19f2d13be40b6b9

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

