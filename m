Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398811;
	b=hAeEFtPeMtXIBh+h5q/C+4EJyFeW/yL24lVmV/gZTfxnFIUy4kwi48ozTgrgqYH/4ma2
	 xtelvDqR0caL93dGCLdUwjMHCBRFCEe7NubMLiGsctBIZR4yQFGrFRGMl5tVkfKnBlNzh
	 r27UwPyO+/IYbG9Hawn+L4nbY9rGu+kOuubN6uCxSUKwuRCEs72IMJVakMuxAoor2qN9r
	 0UPKvJio5s5731vWRyT1/46ik+yqfFvGcWhduJ8dcC737r+VhO4lpDE/o3Bhsy5o9R2sl
	 27pQqr/v4f8bBJowtf53SuSmh3qjhu1Xxjteou2i5Z8XEQROHo4QgGveqJSPnhhgwfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398811;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=26hoXQv1+2sn/TaT/nEExKCOF1r2JApRW5LHjLtrm5GjBHFCmI/OMozrtBY2NJ5x40P4
	 4khyi3cjAeRjS/ooGuSImsZfAHYxADRoZbcD1Ju+9Du7cs40Ff6/ixnq9LWWrW8qipS71
	 1EavhHrR9kQwB4gAzfBQjUbTIlJ6BFSiooMbNfLqqmboJDrKqVz0Szf3YXYk+Lr/s9bn5
	 WPvSOeGIwl/6+OWnrUHSXpQfE1S1MIpX1tgFdvpaFxBQoOiL8k/evo1N29zKd/dMthfeL
	 wasdW9LMJTFlT2WEq+W2iNI6xm//fbrexpp2GRKLYyXRVzQmP67Q529acfZHAnobtSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crFMHtxj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F28B606A31C;
	Wed, 11 Nov 2026 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crFMHtxj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AA11F00A05;
	Wed, 11 Nov 2026 12:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794398810;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=crFMHtxjA2DK0o+D7oT4NtdIO4sHhu9vflTr8dsuN8yp3RRrLVBAWqCvxfscFigwH
	 fD9f8uEVL7MrhXLE727SayWq9awQVdxixHlv1lkNL+KhtZSHK/hobxFCVobwmM4F7L
	 ADjxvnNLP6SBJZKLqKMRNHa3jFuHH46KZmVaVepz8oz3oGliXiF0t10UIlSAP9kvxp
	 LPYSfK6UoP+xplF14zzTCXGSM8pKbRPzwV3lju0F4TQBUkXatlrWmL7PGDixuv7+hV
	 I5ilmUNa+R8uJR55ALVWxz9yNt2Ou4CwlTTBPxH8NNNozO/hUbZhhgzRDpW3YzzJHB
	 /FITP/JNzsZeg==
From: netdev-bot+sinfo@kernel.org
To: Dmitrii Iakunin <zeil@nebius.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 NB-Core Team <NB-CoreTeam@nebius.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] net: validate IPv4 checksum start in
 skb_csum_hwoffload_help()
Date: Wed, 11 Nov 2026 12:06:49 +0000
Message-ID: <179439880966.2168702.12213632482366958763@kernel.org>
In-Reply-To: <20261111120448.49979-1-zeil@nebius.com>
References: <20261111120448.49979-1-zeil@nebius.com>
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
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
