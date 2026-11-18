Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999028;
	b=ONMzY2Tsdo+r+674ACBd/8jgbrWq+Y853wn++j0SWxIpYuJxJko9KILMFNpDWtD6GS+l
	 ai1SDAPKMb8+does7e6flFOK/uqWTVn6K/XsSY1CquVnhnjaRfz70+YzBuendW1BXYdOI
	 f+SRDOeR+piPRDkc4i2TVMRxIc8qcWTsOF1DTEFirx+yoszKZv2jABq3bpssjHOv0uc2M
	 mv1yRdf2mmFkRcF2zsAYZDnPjjf2CA8Hcf7IvYdbr97GkRk5mosIOnEB6ePPtlKbwY0Lq
	 ZsCw92fN1c3pihObxZQdIIKVLFk1NaGgFs9qU+2juNC3d1vv00U4woGIOJ+luuSKWbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999028;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=2tyJQEQnFeWwomXQ5IRkBcHcwvd362+cG6pq/T5Bwi4=;
	b=QU+yJIIvXQV/elyx2dUWg7yLpPk08YeGVf8zfcMDKa/yFYCJmEJGNriLdAICIKo1KZVk
	 aZQImw1nX1eFKRA4CIJdYGPorSQXYmYdptOb6ycG5bi+nkXLEb91i8QbJUpBNGnzgKsSH
	 iFAJzzswYNDXhctf3Qu0+tW26oDbxo3y4nPb3jCeCWJmUNLPv6oPDgBRmT4rUgh4y0g7H
	 0r2wEDP6HSYx6o4xCK9z+b+A5RllK/zRri2nvNT/xelBLmyuV3O5sSiFLtTcid/BPZ5Ld
	 uGw7fj6QvMYl3WiQlAqzLu4+mQIUQzKMD0t/I5/cNzi/9JWUm7J48W+pMzrhJXqzFpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Pr//q/Y8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78383606A31C;
	Wed, 18 Nov 2026 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pr//q/Y8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03ABB1F000C5;
	Wed, 18 Nov 2026 10:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999028;
	bh=2tyJQEQnFeWwomXQ5IRkBcHcwvd362+cG6pq/T5Bwi4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Pr//q/Y8OiVPLDdAT5oOmIcmCL8xXTs8vFj8sUFKQYdCvGikTJ0MxLgfNrOxR0Ta7
	 AvTRZmLuVgJcBFYzqHm6BJF+z8/n8NgYxsuIdIhK3XrCehTmx4m77tW024J0HY7NaN
	 TCsXb/wtvXkZ97WVBVrd5ZNfmeNPReiJukadaoCOGcU0xmTOwygDw8RetcGwRI83bA
	 EZDxFtJH54PQVrXoaFNElTjvs939KZH+QAnzmgH2xqETia+5LNJUHTvcsosMOdFE3J
	 NPf/f7/QyQoOlw81m8LAQrJSKwq5Z1SVPncq6MUyzIBgRZRfIv3KsUzMGyCy4bVghB
	 bBpHjPargRbJg==
Message-ID: <aa9a2189-71e5-409e-b89d-c14441bccb72@kernel.org>
Date: Wed, 18 Nov 2026 11:50:20 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v5 0/3] mptcp token hash ordering and token 0 lookups
Content-Language: fr
To: Hang Nan <2122295973@qq.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, martineau@kernel.org,
 geliang@kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 willemb@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <tencent_50E9A78F95855D54DA67136F3D8520017F0A@qq.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <tencent_50E9A78F95855D54DA67136F3D8520017F0A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hang Nan,

On 16/11/2026 15:58, Hang Nan wrote:
> This series restores acquire ordering for the mptcp token lookup and fixes
> two pre-existing defects in that hash table which ordering alone cannot
> cover.

I didn't do a full review of this series because of the build failures,
but here are just a couple of quick notes:

- The patches you send are not linked to the cover-letter, see the
  In-Reply-To [1] pointing to a different Message-ID than the
  cover-letter [2]. Your messages ID are probably modified when sent.

- Please wait for Netdev Sashiko [3] before sending new versions.

- Use 'mptcp:' prefix instead of 'net: mptcp:'

- Split the new kunit tests from the modification in the code to ease
  backports.

- (Honestly, a test for a !token guard is probably not worth 50 lines.
   The first KUNIT_EXPECT_PTR_EQ on the empty table, or no new test at
   all seems more reasonable.)

- (I agree that the Token 0 is never assigned... in Linux: the RFC8684
   accepts it, but the Linux implementation don't. Maybe mention that in
   the commit message to avoid confusions.)

[1] https://lore.kernel.org/tencent_BB8DA72524E32FD374B8B2950B247B62E207@qq.com
[2] https://lore.kernel.org/tencent_50E9A78F95855D54DA67136F3D8520017F0A@qq.com
[3] https://netdev-ai.bots.linux.dev/sashiko/

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

