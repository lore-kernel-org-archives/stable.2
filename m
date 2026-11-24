Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561389;
	b=M2WyIJnShAiOP28/e43hlQ3MSg0DjMDWSducamG7InmYEnNM0glwcJjSRE6UPsjbQUDA
	 rroMdh+4Dcpt+Uml0IDdxIbtXhs6OI58rFkLk3VMoQhMy40UD27okMamNFxAgc7GvDNyz
	 +FqlM44yL30fL9dLvcwl8GuRLu12rMJ5UCX19Z7S57BjkMkXquayMZnmejSFFUpCWCUk2
	 XffvJMncR5ASNU8J4oPgM8Saahq73nBwFAl6VL2CXf4cU/BbvF0RyOyZiBv7JUS+9v4rw
	 N5qaTUUN+RbQhG6N8EVFgDTslUaZwGAwrWGHr92pClamV+sSsxQnbPOBDxDW8pc6b8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561389;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Continue-Snatch:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-AuthUser;
	bh=kp/deucgwzKBnen3+3AgwDCnzUqKLXSpu8EfTUn6Izk=;
	b=vTz7g7cZdbxuTUPb1uScfBPw+ALKA9HH3FFBTzASRKWK0EE7Zu23RNJLgMdOti9DTGuu
	 oZT8CQ7kTvbJBUmaLuEFdSejTuw+wjmySBYdU8DhwsJIfP36WwXOwGmTPazuQNHmSsdeT
	 mLbUDyy2RJDPZs4D2jJG7+AEeRKgWnrTMz1aaJuiu8bDspuzhz8QR1h00rswztvcSfeN1
	 yhiKPCZFztRiOU1hCPG/2e03kPIKhmooElT1FaaJQ2g+CBK3XBUXHtsWd2NvnPeaul4u6
	 vEvLc7sWYagHTcoGfYGSyTPsLDenAjfjgH4XJj9UAyIFBTbGtI1lNazowGYaLnLY/Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sim.vu;
	spf=pass smtp.mailfrom=sim.vu;
	arc=none smtp.remote-ip=23.83.222.56
Received: from egyptian.ash.relay.mailchannels.net (egyptian.ash.relay.mailchannels.net [23.83.222.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB2606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 23:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FEB2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sim.vu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sim.vu
X-Sender-Id: instrampxe0y3a|x-authuser|brad@sim.vu
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F0A55642983;
	Tue, 24 Nov 2026 23:03:00 +0000 (UTC)
Received: from cpanel-010-lon.hostingww.com (trex-green-9.trex.outbound.svc.cluster.local [100.97.173.43])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id F13E2642996;
	Tue, 24 Nov 2026 23:02:58 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|brad@sim.vu
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|brad@sim.vu
X-MailChannels-Auth-Id: instrampxe0y3a
X-Continue-Snatch: 32cdd8697f597c43_1795561380886_2841758545
X-MC-Loop-Signature: 1795561380886:1204463361
X-MC-Ingress-Time: 1795561380886
Received: from cpanel-010-lon.hostingww.com (cpanel-010-lon.hostingww.com
 [18.130.191.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.173.43 (trex/8.0.2);
	Tue, 24 Nov 2026 23:03:00 +0000
Received: from 162-195-230-196.lightspeed.wchtks.sbcglobal.net ([162.195.230.196]:53986 helo=epyc.attlocal.net)
	by cpanel-010-lon.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <brad@sim.vu>)
	id 1xVzXL-0000000ANIw-1Adt;
	Tue, 24 Nov 2026 23:02:56 +0000
From: Brad Hawthorne <brad@sim.vu>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	david@kernel.org,
	surenb@google.com,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	thehajime@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/nommu: keep the maple tree in step when mremap() resizes in place
Date: Tue, 24 Nov 2026 17:02:34 -0600
Message-ID: <20261124230235.859633-1-brad@sim.vu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <awXMCqK5H2TOlvtf@gremlin>
References: <20261121083139.803682-1-brad@sim.vu> <awXMCqK5H2TOlvtf@gremlin>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: brad@sim.vu

Thanks for the review, Lorenzo.

On the points you raised:

- The comments: agreed, they go.

- The unused iterator and setting it up twice: you're right. The
  iterator can start at the old end, check for an overlap there with
  vma_find(), and do the store, set up once.

- The preallocation: there's no lock here that forces it. A single
  vma_iter_store_gfp() would do.

- The casts: they follow the rest of do_mremap(), but they aren't
  needed on new lines.

- Why the tree is updated: a shrink has to clear the range it gives
  up, or the tree still points there after the VMA is freed. Once it
  is cleared, a grow back has to store the VMA over that range again,
  or find_vma() misses addresses that are mapped.

That leads to the question that decides how small this can be: does
nommu mremap() need to grow at all? If not, a grow could simply be
refused, and only the shrink half is needed.

Understood that it won't be looked at this cycle. Hajime is working
on nommu mremap(), so I'll leave the fix with him and test his patch
on the board.

Brad
