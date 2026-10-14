Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4351DB15
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986979; cv=none; b=DWOJy0LfnVqjqArae7A0tBpTgy7MOXULjaNFuDjEYv0NHouwNJ0/vDEKE9MtsbKyRk7zeY3Z5kFdanfdTnOd9edpRVC8Aw9HkSiYN077G/J5Q4UVst52z0YY2Z1xR1NpY4r9RQBFhNYEIb+C3auJWWBGT+L2IVNIC1XIDfKBWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986979; c=relaxed/simple;
	bh=39mqxoQ4FzxldK/jr8JEqlZcLe/X52JSnqR6pmEuz00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjI/BjHhNxuBM2sCHp60yAuvd8N4p/H+SxM8Cg92QE+ycSOO9jdeWrb27KcgjwJIRC+ESkIlzaRET1m6xk6EBb4iVia1DAHn6HYR1ilHYPHFpbFBflLNfzZO4Ovi/J5lY6rx7W76hqT9JX2PHtuAOgcBfdKDWk+l4IieZjRaYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=hHK6r5m+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="hHK6r5m+"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93e635220b4so414946885a.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791986977; x=1792591777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3/Rdq16RXcxQlW9vLdkggo7RE79oEveipYzoAMSsoeU=;
        b=hHK6r5m+YL08aTQqdE500oGvofyolfuOrJ1AHmWONTk3jYoWyqZBS+EniR2mfsCpRa
         7RYYioCIMIpl1yGTR8ThJqIWdjMpZDvFmmT7rkOz0tcin2xd3RzoS5F14JKq/XDk0J0S
         qJOI4NwhVy5oIBiU1dWNk5LBKTgzzL9xFo54ZC8K1jlwuS7PPsVbjr1gWa5t0tPl8onX
         tERlwwyNyYA0KdhGIZNX3yO+fWRVwxBiQ9409adWXo/VHalNbZ/QSsqsefaODBJX6so0
         /+SRAik1Pl+KjQppsIQYZSeXk1zjQZ83d+3ZCY7IDbKT4TIRKfVX9O0s9Aajklq6z6f3
         6zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791986977; x=1792591777;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/Rdq16RXcxQlW9vLdkggo7RE79oEveipYzoAMSsoeU=;
        b=yh6CcrroLrq+tYOU2AyruVLLyE/ZoU5S3eV3JMbPDZ7HN0yZzcrCyEFCE9RBRDAR9/
         mDQnHVMZeeo3JRLZli5lFBBs1Ty7Kz0Kiq6V0Ho8UcXSYC+Gk32kJAqJWvUTF4uj+nJA
         Ak+OSShdIcoB218M5BbAb5V2zYnZf24gg8zLweZCGY4KOM6e4+f6UZFQ4lonYUqqlcIf
         /gBVsyl9oaAo6RXWiOTHCH1GQLL9I0vwG0+taMsxQ1sEeC2g7uLoGkAyo9STCmEU6MTD
         15IQrh2HIQxk5cAVjRX0iHoGDPdOvRQYxf9CcwVbLBEqlXZQ/8joZNlcCYwXNXteTSim
         M0rg==
X-Forwarded-Encrypted: i=1; AKwUvBxstG0mgUq5SoPukuB8mYyWWjCUNcQnzEz2cq6LwBF250XhMWFvPOKO2UUSVi0up/Dw15VYV00=@vger.kernel.org
X-Gm-Message-State: AFq9FYLF7uVzbm4jlc1+6gq+HxY0BiZ7pUJFtB+434Zd4VEv9bT7bGRd
	TlH6U3n3Cn4AuUecbnuorMCP2XNEoYYapjKEE/8323gh6q5hxhaNlvlO0Dp2HqQ94BU=
X-Gm-Gg: AYBFou0jesDglymWjRSv1DH0aq5KH6IJn7TN6BgbxNIXgeJbqBFrZBp8wg0l6JruTAG
	ijtwas0p3V6jA52o3tj0BVZdrDOMHuNF62rbZw4WiN+N/V98HyAmgpQBFYFXCYXa/6+yQ4/5vrz
	5+Lo8XC9Simaic55Hp7JCJxbhOBUambrDaI0qRTQ5hwUFewtwDkw2ROcxItum9kLGo6GIJQgk18
	ryWSmfz9d2UARnVneBu8bfCY+PsHiXYlPki1NMdS8qc3pV3SS646HkbAFi4XMIaKdTB1oSf2D1Y
	YdJKSZkzjFfe45a+EWdINrNAJMfmigSsq0yFVeJaYAQMwngpYu8utrbkp1jR1kJ1hT1BUpPxVb9
	LQ1g/SCerVn8Stbdel7VZmdt4jkgrPd7kqCIg1BFqHHQezpvk3lC/QcrN+t+k90h7Of4tV/DSl2
	njIUVH5aMKhDktQvxpsONNu+yHVdQOVELu1G8UKZqMr3jSFiU1ge5dqC25CwVoiMIUWNGrjhKix
	43s9ZodyFfEKXGp
X-Received: by 2002:a05:620a:2988:b0:939:f49c:1b30 with SMTP id af79cd13be357-93ebd225501mr2597059885a.13.1791986977046;
        Wed, 14 Oct 2026 07:09:37 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5090050sm498788685a.40.2026.10.14.07.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:09:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: netdev-bot+sinfo@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mina Almasry <almasrymina@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: skbuff: make skb_copy_and_csum_bits() report
 unreadable frags
Date: Wed, 14 Oct 2026 14:04:45 +0000
Message-ID: <179198668564045.2.8478350980557034137@toxicpanda.com>
In-Reply-To: <179191473048.99822.411131589969126386@kernel.org>
References: <20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com>
 <179191473048.99822.411131589969126386@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, Oct 13, 2026 at 06:05:30PM +0000, netdev-bot+sinfo@kernel.org wrote:
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

It was found by the Sashiko review of ab9414ed70bd and then triggered
with a test module, not on devmem hardware.  The module builds a TCPv4
GSO skb with 3000 bytes of payload in a page frag marked unreadable and
calls skb_segment() on it with features == 0.  Without this patch that
returns 3 segments whose payloads are all zeroes, each with a
SKB_GSO_CB()->csum of 0, which is the correct checksum for zeroes.
There's no stack trace or error, the data is just silently replaced.
With this patch skb_segment() returns -EFAULT.

Thanks,
Josef
