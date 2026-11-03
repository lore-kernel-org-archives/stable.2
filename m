Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717538;
	b=zxQpWC9u8g/wL/P58rtTED4mjEOMfuaZlV71voaI3IWnFp0BLiVDUeAUMMvRhTrRg6cf
	 9n2bqT+lmGzHJ1gH9FBUTHU/iZFWs+HLKptht2MSi6dufnJhvWDSuD6UJAalInqKKRhyo
	 jl7WwDeP2oiOGU/Yz3rOtcCUxoRp8wzwRLtWEjmsQrfLprw7X+3d3oSPoTmxEcIAOWRYO
	 Kvmkit5R+1Z0q88npwgpcham6KJxxdAMdoG31Z+TvBdHd3Ce66+D/BJFbiZuI56WCm824
	 T+CaDuUKLO/+39ZzQVboDFHJ8lLIJJQpOppNkorggqXBs7+4YLA1yXu9a15nucH/7LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717538;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qp4pjhwYeCGAtxV/Eq7GgOyC26hhQGpWzAC3uf2SGhY=;
	b=wJNzBfU6cST31hyVdRvrShC570mnOPpdho3u2AMHQAYeaJdzp/5+2VSxtfZb6pb8vclg
	 VouI015oMCt8nonWRu3og3eTQYHxRryfp47mof3fQT5kl7xQvwfqiWEB7CyAogGkJeWV9
	 msxy9VdckUZ6c2L4P1L6/nn7dVLaaNcE9y+TQzE8ANxXnrWzuDB8WqGjns4/AuezVAZA0
	 O3n3S/PJSNQL2/ByEyWbcnhE1B/mb0UOv7ptCyHmVDPb+/yU6LcX8UOTf265tMjvzlexY
	 6hMJIQjHb6USIAg0trHZZwngojnNZ+n2/yH4+IUYyx3N+LBX2svbeyzaAeZ38PFceIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Apropl9o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FA3606D804;
	Tue,  3 Nov 2026 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Apropl9o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F2E1F00A22;
	Tue,  3 Nov 2026 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717537;
	bh=qp4pjhwYeCGAtxV/Eq7GgOyC26hhQGpWzAC3uf2SGhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Apropl9oN8jsK3Ap4hgjJI/KEymh0fTH+tU6GM/ezkiQ6Wa7cskVKfyOT0VxGylDW
	 yL4RWrIEbZ3hMlSPlHNxOhag17PLrlGB+g7gFZqpTXDAc0E93f58nH7f8TApDzLKMS
	 CFzJjm+nWFPP1UBMjF+AhIU6CpE3iMhQok61fq7It/PFO7KVlm9OZUo3GF/X6b5ItE
	 xwPef6B5naN/lWhVDdpLgjrBp26YvoHYVcqJZt8EixQHyzj7f4YrsnC4tWMU03YOMq
	 Ho5ziQmsvFJNR+l476rjndMbloWk1Hkwc+/w1KCnP8ZRdLyAW6RumP8Mi6grxV7vVL
	 Z8oS7uQ6VF5Kw==
From: Sasha Levin <sashal@kernel.org>
To: sairon@sairon.cz
Cc: Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	pabeni@redhat.com,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Michele Giorato <m.giorato@mr-miky.com>
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
Date: Tue,  3 Nov 2026 09:51:53 -0500
Message-ID: <2026-11-03-1-daily-reply-0005-re-r8169-vlan-tx-stall@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <0589f056d5fe47703ffb79b37930d3475a8f2faf.camel@mr-miky.com>
References: <0589f056d5fe47703ffb79b37930d3475a8f2faf.camel@mr-miky.com>
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

> I would like to report an additional affected Realtek revision for the
> VLAN TX regression addressed by commit:
>
> c2124f80be4ceb6ec566ca3b5fc87f84ea9c36e0
> ("vlan: restore HW VLAN tag insertion with reorder_hdr off")

Queued c2124f80be4c ("vlan: restore HW VLAN tag insertion with reorder_hdr
off") for 7.3, 6.18, 6.12 and 6.6. 6.1 already has it.

-- 
Thanks,
Sasha
