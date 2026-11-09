Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262421;
	b=EmQmSJjef0tMJ4QCOHvLSFXWWz+7XnerIKi5pnw8dwkcY4CbOEv5QVoV+WXIQ7usjqiw
	 AbU0hqg6XcrhVtR15Jr1jArwCmfLM8HNJ22qJ/WbTcNm1Xas6ZtPSG+3sx1+55f22UcpW
	 WvSrfGxCaAHY0+Jd4eCYjaXwIc/ybH7crbIp8/vsiUMF/d+orjB14dUgRhLPVKsXIBVPa
	 fAR+MVgweexdQtuzqbWk1Y42Og+E3R9JIJc/SKSxIHcJFmKOaqQf4aAhOZjKnIFPHZAbs
	 ulyVpadFkV3JX3jdbYdMeM64fAZmsLXJs8cDScOrvMw9nDQqVkJJKR2/Z3MVjSw6RUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262421;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-Patch-Reply:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QH5LLABATs4svsFZo6uJw4Vz87y+hKpb9mrh6WQD97k=;
	b=AzqTP9XSwnYyqMu/hxdqUMRaE9CiI1o4AjKRUv4vSxmGl09UdAwU4FVvAETAZmIPvwmY
	 vIFYSu6W69YsA9XLBixObgxIa7p+VAfGxZvtBLpf1noIRjsUKSU/4puk18llPJaNTVSN7
	 59QXKfPYu6OiH4DTNe18hbnrpNAoFZOoR1Uubgi+W2XDogr2Pes0/K/I5oJg/kOApCzGT
	 9+CaqCeXN5YWz0x3IUzOtcfxlPCtBszCKZ0dFEHquxd7c+cBUHx7CicjU1stMblI+c70B
	 WPVANjkpsOIKIRqp4hVmVUaa/nH1m8XCtybUCu2yuTJ9NViRDcqh5NYQLbct90oRI/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wf2x2pPM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB7606A31C;
	Mon,  9 Nov 2026 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wf2x2pPM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A801F008AB;
	Mon,  9 Nov 2026 22:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262420;
	bh=QH5LLABATs4svsFZo6uJw4Vz87y+hKpb9mrh6WQD97k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wf2x2pPMH21MlkG0dhPxMCp/bvQmofnSRaizH2CB3UdOJaAbwFDn5bsQq8zeqTYjb
	 pRTgK1Khl7jw4b2RPE5fdLcRyg1UETg+ZpoOuyWByHODXQ8pAbhKESYlysONugMZHL
	 nd5UJxIwGLOnAwPzkOJbLHynGjbslyTp/Bw5KL/gG0J9/iVHXqKUbgYXGbQQbafwNw
	 J6uH92AzAA2rCbG3ueYdL8gBakoCTSifaqySaq4IEEQgowKZqFUpdXuuWA+pro2M+F
	 7Rn2VeRfPD2z9n147vw3HQWxSZIPVDdrFLAnHHXRFb+PuTKts3LSOaYVpkiM+3cYMF
	 geJ+e2EoSc7yg==
From: Danilo Krummrich <dakr@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] devcoredump: fix double free on device registration failure
Date: Mon,  9 Nov 2026 23:13:37 +0100
Message-ID: <20261109221337.3988445-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102082536.1275223-1-johan@kernel.org>
References: <20261102082536.1275223-1-johan@kernel.org>
X-Patch-Reply: applied
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon,  2 Nov 2026 09:25:36 +0100, Johan Hovold wrote:
> [PATCH] devcoredump: fix double free on device registration failure

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] devcoredump: fix double free on device registration failure
      commit: de7625abe4e9

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
