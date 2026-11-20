Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795152788;
	b=p5/jWKLZ/veiyzUGNky0AatUvMZOQaw9ZNtYqPJdjMlZF1FNbsjEh9qB72fiEabkNs4b
	 knwuCAv5ltWUCrcNN8UlrUOuO8McE2GTgt53Sv1jKETEKTEwR2N8bV/QPRX3qO4PJvh7H
	 snfJX7sH4fR1YT9igk9ALWfbCrFPdyUWQYv2ieRNrHruOnM76s5RFr06atnRa2/FL4crw
	 FXG56cdAgP03xKb61waOkdV7TpnVbVt8V2eHPMi4mkNXm3y9TFIGytUUBd3pV4mzb6w9v
	 MOA9jorkDlSrAvp5oIMUVWM3OmnBYnirJFt8FI6Bhux5XXBV60Z4RUuhB+u7ePhVX6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795152788;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=Jdkx+3EqNrUmjat32s2C6lF9VPAh7I1F3oL4QCKykytoBVqI8R7ItuyNjeVUjmoL3n2j
	 LZsVp38lQg90RkszE4qqXm4hFuYcOjWtH0OshK5mRPrC+HT6k/YCnGqkK1sm0rLm9D62g
	 rlz6ZpdPs3mY3JVqFMkHXn6q0uSUIrqVINwYNMnxxdGEEIaRfmbtPIwEoa7tf01kDUHty
	 MmSMcqRY9fpHAERnnDqRJcjAbWjQjSx/xy47+LfrQd+Je603YTEBwLW33cH0GLQjCQpy2
	 6pdsMbY+9WtAmcA+1TD50pgVUb/nicP0xDJBD6/KO8KjoTApf3x7Rhkg7Pyjfzrwi6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0H7SaUU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629D606A325;
	Fri, 20 Nov 2026 05:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0H7SaUU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010701F000D1;
	Fri, 20 Nov 2026 05:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795152787;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R0H7SaUUBBcx9nGsFWthX5Qo7ueh54vdUiqXepkt7uxwG0b+mOqgbCdOvf9JwhDgw
	 7y2TN0S0okJmo56rGs/dCOFYIGg+YDnVNgZH4uxtveJ6lYzhUyWbflK5SE1c4RsiCG
	 qifctVHogunpgTNQsJ5GTzkcNVGEVHxeBbHqBVEHP+z6KEskYcoE5FCrTfyWl6QKBr
	 KdujZH/fk5xPPwSrfdjhMYJ54z2OPmhz6JxzEbaHgV/T+Nzg8MxV4x7KzqQ4lajnfR
	 Ik6C69exEMNpr2GnaAaKKauTFt3iBnj0NRBeEoykLKFBqD0WGtw8UKAL0w6iEIdo7g
	 JibZilqDo02HA==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, ipsec@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH net] pfkey: fix kernel stack leak in pfkey_migrate()
Date: Fri, 20 Nov 2026 05:33:06 +0000
Message-ID: <179515278654.3291.15470389162684416148@kernel.org>
In-Reply-To: <20261120052814.3686573-1-bsdhenrymartin@gmail.com>
References: <20261120052814.3686573-1-bsdhenrymartin@gmail.com>
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
