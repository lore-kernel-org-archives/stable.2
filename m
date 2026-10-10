Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AEF3806D9;
	Sat, 10 Oct 2026 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791612977; cv=none; b=U4He7FoouGW3BiAvTBv4dhu/RV8ZohKDV3b+tbMwAOqGQWKZwbRYUh5fMwmQVUxR2t0F6qXmmeUlbIFBy+N2P66+/Ebq5twO/mrHJ/V+zbKVGb1Xacs+GmJoTAoqKqKNA7d5oQc7jB5SkD6ZAlrsqgsDETg5+/g1sPHEVsDBg2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791612977; c=relaxed/simple;
	bh=Fed2iCEhr9Z47YpFnxy2lq1ieZydhUdYWRIloiB0a/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Igft4oXHTDScYvnloo+c2yLibEUBfTf0kfPapgRHIYLp8P062fdwMM8x3P2+dXZhvxogvBp4LWXBurN3S0VkzNl6HtafRsBEWdlbfi2YgJp/boZbX6ICvjQ9kj+z0VLRxUxiTsI/Seq2jsabZgKU4Enpi0Rf1x30DHD7eiphcEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2bm0xPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2bm0xPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466791F00893;
	Sat, 10 Oct 2026 06:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791612976;
	bh=tXm9qeS6oWT/jXocMG3/wRmVEOzFICwnC65SzuJjfvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C2bm0xPjCOo/wGr6Yq0IGPvTMlKPY/vmaxzPcFqSfHPZ3tmzEMCF9vWnWg3gKDKFn
	 8+k99puu66D1fQhU6fH7gunJ3UODkkvvn+4BptffRGnl1gPFsaqUd81LBsyFX4E+Rt
	 BwDX1EAuZHRUXpP53ZSH/8KIOEeUe3UhWKn4TJjeRAXNCIyOz8PWTt1J0bsausjyDT
	 EgP1REyVEsiMfOjsY8TF3eAbywHnXM5yIaEcE8s3uP4f+4RvliXD8BxuVjvi2CaGcF
	 JcSJxQZTjBnQOz42PPJOviz1XOI07YloAiuDZ2htl9h0H9n+KqxjyPb7dU4DNQPuYM
	 jNJpvNFbRt5zQ==
From: Sasha Levin <sashal@kernel.org>
To: Dennis Piecha <d.piecha@ymail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@kernel.org" <edumazet@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net v1 1/1] r8169: disable EEE on RTL8168h/8111h
Date: Sat, 10 Oct 2026 02:16:07 -0400
Message-ID: <20261010021227-rc-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9777c133-0d46-4efe-88d7-8a519f38b0f8@gmail.com>
References: <20260925071040.2137178-1-o.rempel@pengutronix.de> <179081461327.2189941.5041238879527277665.git-patchwork-notify@kernel.org> <503211732.1051249.1791285565321@mail.yahoo.com> <9777c133-0d46-4efe-88d7-8a519f38b0f8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 07, 2026 at 08:01:06AM +0200, Heiner Kallweit wrote:
> On 06.10.2026 13:19, Dennis Piecha wrote:
>> defaults, no workaround. Before, on 6.18.52 without the patch, it
>> stalled every 7-20 minutes.
>
> I'm pretty sure that EEE was active for this chip version in earlier times.
> Are you sure it's not an issue on the link partner side? Did you test with a
> switch between your system and the FRITZ!Box?

Stable takes this for 6.18 and 7.2 because 202fef9bbbf5 ("net: phy: realtek:
fix EEE advertisement write on the internal PHY MMD path") reached 7.2 and
6.18.46+, and Dennis saw the stall on 6.18.52. EEE was not effectively
advertised on these chips in those trees before that change (the advertisement
write was a no-op), so your recollection holds for older kernels but not for
these trees.

It only affects RTL_GIGA_MAC_VER_46, so the downside if the link partner is at
fault is lost EEE power saving. We will follow any revert or rework upstream.

-- 
Thanks,
Sasha
