Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016081;
	b=0RuGgqHHyxkDFbYPcCmlLfqIU9TUxhQUzzn+50e8gdpHagIVDB3vwr4Po2E9XMgqPViL
	 dX7UpWF2BC1PrWM+5UlQ6UB+9wNrEkSgkYlo6VNbEpxZH4BNCKj6yWrXEg/ZhaVavCOvi
	 G50JLF8D4vARiDQonI7wFYyuKxCSleVb6Fd0E+Od4b6MNxd9MLGmHn0n6CTVnoMoRn/xJ
	 iZHIJOtnfxqDbYLcz2Bcg3JLAGQMi6Ft5qxDB8YP2bTlOSr1k3eayG+bBIQtUnsbNimrP
	 DFpTHXTS/QWukTOZkdkwDe4cZReUxyho+ZeJuaOu9q2aknM8nyYp+Z+KKh9v61hS9Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016081;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Rcpt-To:
	 X-SA-Exim-Mail-From:X-SA-Exim-Scanned;
	bh=VSKTGS1kbTM4dMm/+vlJr4N2XDJwQxqae+AH9RGyFRY=;
	b=2UdyrvvrbUkAyvI74m2IqO8g2PfI/ESxkCXT4s3hL9Ob2TIdCKe07hCcIA7lNAKntbOV
	 V7OO1xLyhMVvaVC7j/Qb22nJbx7WhDKc65/cFhKXI34Pf5PzY7U/NEQRokt0e9oK6V/Ke
	 zzTCtmXUkD4mmSMHP6t3LECbEKiG1bNYniqXFEbxNl/PqiGDPCAkQpkNAVFZtzHyh07tT
	 V5FC4WcyAp/yhdmSWOhkfoaKwSLQcaeS7C7fBE1RqIxGc74yE3fyiGRIrtpCvD5A/BFdQ
	 9CdQjM6Q8DaMFp+6GVF5NRf+qdAM/joLcRywRIC8ent2yUZELCkEA7IISaLaqEy9ksg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnJyoaga;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E046760A2619;
	Mon, 26 Oct 2026 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnJyoaga
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD80F1F031EC;
	Mon, 26 Oct 2026 12:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016080;
	bh=VSKTGS1kbTM4dMm/+vlJr4N2XDJwQxqae+AH9RGyFRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NnJyoagaZVtSuFTn14MzbzRuxoXp7Jn5pwseqAP/mh983FfXGlIfgyQXIv7O+Tax4
	 Re2mkwt+KycJoxn/i+oQ1/QbxJEPaWm4vm8wApEOe1VbKftTF5J9uwNeH/qCVLeEkY
	 lv5K+Hh2MViuiNLXnYmNh7KYb6BjhlCU9tCINq0QVdRXPnAhvtYG+ECvftvao0kCOZ
	 Q6/0Jgx4FCprlzUYu18PVj+SFG1mGZxhCgKJBggzFGmdImB0xeVuxEUf4FEsB0E6fZ
	 q8CRUot77hmZQwGtCis/QXrnQaN0TxDkLMiqORgrMSbVBqP411LswdsG56FfC2cx55
	 Wlygt/DjKWRpQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xLJOB-00000007Fr6-0STN;
	Mon, 26 Oct 2026 12:01:19 +0000
From: Marc Zyngier <maz@kernel.org>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Vincent Donnefort <vdonnefort@google.com>
Cc: mathieu.desnoyers@efficios.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	oupton@kernel.org,
	kvmarm@lists.linux.dev,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1] tracing/remotes: Fix TRACE_REMOTE build when TRACING=n
Date: Mon, 26 Oct 2026 12:01:10 +0000
Message-ID: <179301587198.2527370.7827341463820241821.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261015112814.332084-1-vdonnefort@google.com>
References: <20261015112814.332084-1-vdonnefort@google.com>
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
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: rostedt@goodmis.org, mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, vdonnefort@google.com, mathieu.desnoyers@efficios.com, kernel-team@android.com, linux-kernel@vger.kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, stable@vger.kernel.org, lkp@intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 15 Oct 2026 12:28:14 +0100, Vincent Donnefort wrote:
> TRACE_REMOTE relies on tracefs, eventfs and ring-buffer which are only
> built and declared when TRACING is enabled. It is however possible for a
> config to have FTRACE=y TRACING=n and TRACE_REMOTE=y.
> 
> To fix this configuration, have TRACE_REMOTE select TRACING directly,
> just like other FTRACE options do and drop the TRACING dependency from
> NVHE_EL2_TRACING to avoid a circular Kconfig dependency.
> 
> [...]

Applied to fixes, thanks!

[1/1] tracing/remotes: Fix TRACE_REMOTE build when TRACING=n
      commit: 3bb853ad84244f0b86ab12f029bc4a0c9c7100e8

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


