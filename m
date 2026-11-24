Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509473;
	b=Bx5JivkD8ENBE9gYuKoxhWHbApjyst1qGDrYvmAatS9fppdUAsIOxyYi3OAj9/vukgcP
	 nHF2szYY6C28+5ERYFweGXj3SvOTAViaem8J4dK4M5sepPrRKiS73xzi+adB2pSgcIFSJ
	 eYCODd8hD0jfBAkdQBTO4KcNSaw1GynYt30oy/q/+jGN976IQ55YTTBKBYc98zZ7SUHWh
	 Ef+aSghAt6TQTbC7JVIWmbpdU/5/ZVjegESI/1g4KRJBXAON1+L7YdELlioCPtfKQwvGq
	 I99plbMJhgSguNmMs2C8Xx7XXXZzn8ERYFtbtSAdUmbMn/qBYxFNSyCeVas1f3E3C+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509473;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=bPggl9rswxz+svg+eRmf+Z3knA0mi5RCdtEPpyPvmQZKUxcKd3hasfHZm837wTC179d/
	 WAo8E93UX44jcweCsv0Y36Uc7uNnmZzgfqaX3YMR4CXvtJh4h9qRmk2dfRc9uFe+OqZnW
	 BjstxHDGrvYjMuJB0ruF3huUdB8LOYccyWekLpQg2EdaTSaO++zEkx+KEg1ta/qav4v+A
	 U0Z8/AjmeduW1nLUVnuDh4jYKsR5oWIyQQZoCD375cMNM2m42ZIxKDv5BKbBnCY+7ZAr2
	 cvTvhmN0T/kwIhO6d/F0Y9AdmTFO81g4fWbt8Qw4tBNiJGGp+7G0SXB+3c1NcJp3VKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcuoUEi3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F58606A322;
	Tue, 24 Nov 2026 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcuoUEi3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABF41F000D0;
	Tue, 24 Nov 2026 08:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795509472;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WcuoUEi3CxP/6vjQSlWwJSA5F4NV9NKiBJ3Qu3F+/PwvycBkEXzRGWQ+bLqZO3gLR
	 jF7rtAzacJRJSQEF5LIcALYNRT7wVVil1h+RvVXSyH6hggEMlaR09Vr1UN7e1Gjhri
	 pgwRYoaLq5z/RPPH4VgYjqlfjl4iXApPpXIfi8gA9XiLgJHOhViUqnyT8BHfi6vYyb
	 BsJHSJyiwlcSDQlU2+wnpGSjdbNvJQte4nFR5vh1e+JQLVV+dWiRVj9htVxC6vZFfH
	 dLAqFOW51GpRPARqrFhpzGRGGwuZc1ia9f6n5C2pDMpN8+XXl+kUEodGXEaEsQe2eM
	 1ttnGuh3aJsXw==
From: netdev-bot+sinfo@kernel.org
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] xsk: fill in header offsets for TX checksum offload
Date: Tue, 24 Nov 2026 08:37:51 +0000
Message-ID: <179550947159.3294.6288731111531309964@kernel.org>
In-Reply-To: <20261124083520.45547-1-kerneljasonxing@gmail.com>
References: <20261124083520.45547-1-kerneljasonxing@gmail.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
