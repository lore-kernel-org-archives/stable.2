Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738148;
	b=1lcSAQ+eo/AAtl0tykEaGk7MLhjQWcaA38SR6kkKYqkmkbDO1aWENUuFlnfF+CYEzd8f
	 m8fcm6+j+nR6veZ1zg5LqdcbrdEqYjKu5tbkSV72bVF0nsQ5Bmg0Bac7jHK9gRUeCMoK+
	 JYYWWyhnpakq+wWF4CuGTwdPtjTw+5yr3NV0naFPk1ylqbXquogkS0EEA2cPLIGF7lPxg
	 cyl3wq/1Nmlxug7xyJ5QQ2/k0TpckepyxCLkMBIvJ4m9FVdpOMwFmaZXfJ4qw2XZXQb78
	 Tmf0/z2B8Fumky46omYSS+jMlkN/tnUU6nw6NTKuXtVaKfqUvKqA3gndlkkssIhIiXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=erqFqVawVO5JWIlkFRt7XSARlkgrx+IN+sYh7a5xpOU=;
	b=tDmCKmqwVelGPzA9qyfYl2j7WSdYjuWlXoiHnDCWmVzlBBmshLfaEWa9bKRlK/8tOk7h
	 8tK/jmjb161bTh5Yy3GWTRFAcNx6adilW80GprV+8H+l/ciRkpluwLD31bWVcHKqxpXUS
	 RhMWS6pueBA3xEoXtDP2J6b7C2lxrlbDPSQ8D9RtQNp8uSRT7jR5jibyQnC+W5QZjVp2v
	 upzvylIuEV/ynqKd0lO7h2dl+/q5UlZvhSiOXv+m0TJVenJbgNs7D48ouG+Ya24XO5Wc0
	 hR9NOoUH3CsbYTt0x0NU/sp6fRdBMuaM925NQDoVjEcNVU//Dy7+R0+c9215EbO+psA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i7uMGkMX;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ACC606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32ACC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i7uMGkMX
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso348853a91.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 23:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792738147; x=1793342947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=erqFqVawVO5JWIlkFRt7XSARlkgrx+IN+sYh7a5xpOU=;
        b=i7uMGkMXscHjhDENCGznN0F0LdwXhaeeK4wgq1V7J4s27ItdUdgiunUqSxsF8PqGG/
         RDNvW27StQY6+J/7pi2NNhXsIBii5GWnzc0xn9xTKKIFh8JsYVTB9OmSKlOBQxgM23++
         1qayxyHKXlS7JCxOnpQwsMiqvhs/BITHAtV2XcR+u52UGYFT99pDYDdbrT2EpjGofscq
         Hy+ASifE6Vm/184hsyDxfFrP2DfFgsVzwMdjGBP4X+j97Afa8pEqJ53zMJ5TI7nLRVXo
         OnffgizhsnSq2tku16pbj2V2RImO0esUxWDeT5yDhDMEzAn5j2FgguIN3aVETuFQaB0a
         d08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792738147; x=1793342947;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=erqFqVawVO5JWIlkFRt7XSARlkgrx+IN+sYh7a5xpOU=;
        b=PL/lwyuIJmavDhNs0gJgXKlIzP4PohjIxo1pLeIKLFqYIBI5Bg72tAzf9UneCHMRy4
         hz0xjDCYRyZuhXIlMuQj7ALKP3bp/nRaIw5OcDUTztwEC2UtiXpDQyrRbJ7HFVSQ7rTx
         QYbdJPt/weo+01PDKJ+6//jXd0OgHIanIOTk1+4otm4lWCuwQyp9DS3FGTrTE6o1pUY2
         keLSTtJINGfK5V8nvIh03vuI9yTM91p3ZU/73MKmm1tzNSBwal9IFwTpwZaOZVIi/1ls
         N+Ob1GfRfSgtotFzI0qV7X8NXRpOS/snFSnniWtitJM0Alpom1vxAO6syXWGaTz5wfQG
         F3Gg==
X-Forwarded-Encrypted: i=1; AKwUvByasR5NMYPmGdW3WJFnK2/xNExXEom1Gk0NFwMfXmnBjm+wKpuSJXTF1aY0NHxDsjfYFSN4D7E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaJrggZvIPvdh986ZUfaB1e7y3nE7P4uY/bHn3OwhfjocBC9ft
	W9VXCd7ZlFhop9vwzqjzmpzKr4B44+fAtK7IJEfWdCI9BLqM/xc1JFVe
X-Gm-Gg: AYBFou3NLp8+WqZPa1BdLit8SqOV7h/dpCKi+KwIX8f/BeYDbYON2KriT5AiEY1kCGz
	3aUOZaYRPh1aFGCXFJyc9OTE8cZarMY8dbi0sgMIamiFxVk277C4uc0gOt4g8DnMm5Z3nT/Z44x
	pazZf3x5BSJpnBMNxUsthIIYlQDRRTptUNEnQb7TWW9UM/qAFPHNNYAPzwRzc84zyOKUXVRE9z2
	NqqeOqpyv9VPNemzgFlgCeQI8CNe2/R/NOzRtIug3qyZiOt9rnWCc6QrsyEjh9ecjbT/Fz9AT5O
	7UhCaAAa8UiSszNcbape4b/seE56Fy3oTF3k+I1Q5DUpxbUDRdIWEtE5cSvDs6ekyubWwefj81S
	+ylESanR+zDBc0VWKB8ChN591X0eNsYKjhte3HGqBwez04VNV2XfnbLVpFmms7cdyTCzJaHdPmb
	O8t0DhaltBvCclwcMt+JgNr39mjcL8jPySrBrkjpxyAnmEPtOhxndTRzNwAoZeYhEMFBvmUbGrH
	6DOXMeh+ZJ1LB3cV8Qa6tT22k4oXU6hJsmYI9wCyj1G+Ie/icPu24gmsAjJ13n7GJc7Jpe6RaOt
	KoIbuKU0+L1ar+3oY446MgMJphJsQRSCRsvCcuDcZZRQ
X-Received: by 2002:a17:90b:3904:b0:3a8:6045:5a24 with SMTP id 98e67ed59e1d1-3adce45d61bmr1003380a91.38.1792738147399;
        Thu, 22 Oct 2026 23:49:07 -0700 (PDT)
Received: from localhost.localdomain (ip67.244-167-222.hkg.ten111.net. [222.167.244.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3add29dcad5sm615871a91.4.2026.10.22.23.49.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Oct 2026 23:49:06 -0700 (PDT)
From: Guoshuai Yang <yangguoshuai@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Guoshuai Yang <yangguoshuai@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] xfrm: esp: reset outer TCP GSO metadata on espintcp input
Date: Fri, 23 Oct 2026 14:49:00 +0800
Message-ID: <20261023064900.64877-1-yangguoshuai@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179268155570.3135.6366960419287611684@kernel.org>
References: <20261020030450.7170-1-yangguoshuai@gmail.com> <179268155570.3135.6366960419287611684@kernel.org>
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

On Thu, Oct 22, 2026 at 03:05:55PM +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> Is this reset reached when the outer TCP GRO aggregate carries
> SKB_GSO_FRAGLIST? It only runs after skb_cow_data() succeeds, and
> skb_cow_data() can fail on that gso_type before we get here.
...
> The skb_copy() WARN_ON_ONCE() itself is older than this patch. This is
> still the same stale outer TCP GRO metadata problem the patch sets out to
> fix, and a reset placed after skb_cow_data() can't cover it. Should the
> outer GSO state be handled before or inside the COW step instead?

Good catch. When an ESP record spans an outer TCP GRO aggregate carrying
SKB_GSO_FRAGLIST, __strp_recv() places that aggregate onto
skb_shinfo(head)->frag_list with SKB_GSO_FRAGLIST still set in its
gso_type. In esp_input() and esp6_input(), skb_cow_data() then invokes
skb_copy() / skb_copy_expand() on that frag_list member and hits
WARN_ON_ONCE(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST), failing with
-ENOMEM before skip_cow is reached.

I will send a v3 that unshares/unclones and resets GSO metadata on any
frag_list member carrying SKB_GSO_FRAGLIST prior to skb_cow_data(), in
addition to resetting GSO metadata on the head skb and frag_list members
at skip_cow.

pw-bot: cr
