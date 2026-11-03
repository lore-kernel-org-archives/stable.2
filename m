Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701999;
	b=t0UX8xUR+zZAxGuLeD2illS0d9LHaNPotybSGVnru2yAZBYkOYqdI/5g61+bjNPpvGQW
	 /frnTlYr9uBLf+iAD5pi6b+dALgaiqCAcr9laA2teWmCaBjX/gmMBAkIRxO6cHLAlkZfB
	 j+ENk2s4Kv45kRKOPyyoxXfOm3CyItpe06e/QZx41xv8ufWlhAAisyidVucrXqBatkKUn
	 nG95OcIp4ZxDM15acgVesrmqqQirwvKyzocNAXCrpHsIh03wXhL3x699Y9cadjwiV6oUy
	 TgQlNjmUSOk/w5p2dyV0wr1KsaaR9JViuTdMdd/7zzT+1oFzwkdjjzGCHbCBRtaIPXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701999;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=QmEYnbFw4Cs0Okt5D7l+AhfQ5kp2c9jylc3sB+pU3mSbJbctCfOviyYCnonmnHmGgZtr
	 nZMTux/TWGt503rn5Yulfn8tXw0mtUmt0fdyOmHl2WUysbMY0ZNPkQjUSHekPTj2PsL6X
	 Omr77EMzkf6Mbk7swa7M+vFl1ZU+Znr0XPelmnWq3PMjKge4+YQu6cbBsqDC+VI+bvtOm
	 I3YXppujaIKO3L+D3hTuAlT0whF+pCvv3yQPaMcP3L+fpk9J5gkf3mNAJopqL7PX/SGpX
	 OLJQdv6A49qQ+3ciB76ivNPR32v5Cp8i/U/E+j9Cj13LKN58z8BMkskpzAtOsEKn80g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmtnTh6u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620DF6070A8B;
	Tue,  3 Nov 2026 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmtnTh6u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5987F1F00A1A;
	Tue,  3 Nov 2026 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701998;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KmtnTh6uZ4sZQM+eSITPzn16gnhLwhGpNcIRtKoELyi3p7uvXXKsGs4ozE8ZvEI0d
	 l/MhWzM4gDjV53s14djbpRk0itNXgWChrPyf+jYR0isCBI3HnpgDcKQCGWofQu5Mwf
	 pMYi4M5++4o0inqUQDB6Rc4+jDgYhOzHJjEPKQOPe30FoqaVjbBGPgXoB9y8ADX3f2
	 buLJ3dvyVdbJF3PQQtrrpaYohi+kRgMEcC13mbPxrLmBSn7DhJDiGb5g1Ifwy8zbos
	 KnJIdHb40KzoBMnoKQet7kZC6+IQ05z1+9/3zIR4zhXFK2Aiebu6IoZ5ZXKk3et3Za
	 SJTh0TsuMIGEg==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mlxsw: spectrum_ptp: release parsing depth on MTPPPC
 write failure
Date: Tue, 03 Nov 2026 10:33:17 +0000
Message-ID: <179370199786.488859.780851343951106497@kernel.org>
In-Reply-To: <20261103102851.1340480-1-vulab@iscas.ac.cn>
References: <20261103102851.1340480-1-vulab@iscas.ac.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
