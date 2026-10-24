Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833342;
	b=LoZMvUkMRQGyAxExihAi5oUzKsidf8jSy5WG5X0QK/vpQsu7Ukd3FI6PtZfk2JDIP5Na
	 Ww4vOUyp7vMhg5F2pHrqcV7YJhfYxDj8fmHrKDPa5YrHvVcJ2F8NvI9yHHzVFYW6jBcM2
	 h/MOjpALn2NyBLM4w0hmFtdwwuS4XbLCPUyBjkGUpSm61NFNAg1eVX8/mGAprfB2vyFCS
	 YdyLgW5ElJC8FSDnTLesoyQbN1JwH+AntlQnFLxDFHzI8kKNTokhU0v0yUpMSybv4Q8X/
	 FrtBmjOvPxkTKTy1k0TGWJQDZfWFPeUj7X2dHGPXjOAtHn0tTFjbgWiWDNb8KCD5Muw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833342;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=Kf4glnOLIrfZcEc09/89DQj0B5hw0U22l7HfRKGpBDWj3G0/XxJcoCr4ShXKPMNMwgN3
	 J4JiJL5mDvZbFX3qilM3VjBsEZlMa1V9pX+uC5n7Exo0WByS9DyoLAsmv/U2ueN+RMUYr
	 ifsy0WfC8WdBdVUW+/8ZshBX7CIpGGwFFBG5rNsYYxLaOVtjvU4qY1hthQcxh8h8gUS6r
	 cBW+ka2pYkduIzlB9mC1CrHUU16ukWqdVBCBHJ0N5FOXv/CirsNnu4jwzwgXFr7aAEb0Q
	 ZheE/JVcAU3N/NgW7R1618Sd9JTrugANka5aoC43gLN2s93awpcst9a3wkw6YVKt7iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kc47odV+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA94606A31F;
	Sat, 24 Oct 2026 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kc47odV+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E6D1F01825;
	Sat, 24 Oct 2026 09:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792833342;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kc47odV+5RD6a1ZNZQ276x1U5pw/35jg1yA0FTPBrzv/4NVyoS55tiy5ZhlSYnhvB
	 BGV/AG2NWHul0h1TgVN+ZGRCduP52PAtU+xK0aomdwxCNKFXvlXmQ0GfpCn7lWOLUk
	 98DyWEgd+MWcgNKX9pv6xLeaf5P+ZT1rcmwXjIBVpOfhunpIER/DzJpXOmB2AOiRyt
	 K5acNm6nVqoFpkeUIP1i04EqsWinMbVKwBiKe912TennHftOSPXJgnImthZtZjgNPY
	 PmJD8+OoL6JcSy+QZICT9W71pMn/31QYWs9D0FBfigz3PRyGaPXNUTGwKySnezfz/3
	 3bGtxMK6kXPZw==
From: netdev-bot+sinfo@kernel.org
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] xsk: defer software checksum until the skb is complete
Date: Sat, 24 Oct 2026 09:15:41 +0000
Message-ID: <179283334099.3327.11706883238489839470@kernel.org>
In-Reply-To: <20261024091256.17918-1-testwrzwrz@gmail.com>
References: <20261024091256.17918-1-testwrzwrz@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
