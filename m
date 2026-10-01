Received: from mail-wr2-f39.google.com (mail-wr2-f39.google.com [74.125.225.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D89439F8A
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 05:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790832556; cv=none; b=M4xPuRmqswae7ve21CY2MjF5cTO95QZs3fo+QhpC6mJDbVusm6GezMo8HHnBadSDXf6BWGxtzZ6/U7PPtSfjl6wFJmdQ92xapQKALPkO+DRSp/zldZKng0HErr815doqvWPf70KXTbS46k6NaeWByiE0UUfp+hs82mpxutPo13E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790832556; c=relaxed/simple;
	bh=w/ZOXy+TEhEgZ1n/n2Ri3BayA5eQ8iQykEwzlL4HNag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aX+rjtJi5ldR4JblIVi2EtZSMieHlEUvzRJH69DAlixvTkgUR6G9shSj/qQ4iRsBMAo8h/7wBCy17u/g3+prPOwfpXpl4jkUzxaJwSeBriNHZQtQfO32oQGYt0S0Np9irz2a2529K0Kduf93AELcRXewTWPHXVGEycDRzXwvV8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGEh84kT; arc=none smtp.client-ip=74.125.225.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGEh84kT"
Received: by mail-wr2-f39.google.com with SMTP id ffacd0b85a97d-48af929e59dso1641563f8f.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 22:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790832553; x=1791437353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f7De1psM/c0Th/SkbusqTwWz8XUB0UL58xuHCpdo1fQ=;
        b=CGEh84kTa2AEV30stnv+7obXqFjCixJtY6fDPkDwhp2eX0k7iToX/eD0TOGcqfLCiu
         gAfZh8bNjizkzWKOKYou+sLuwv9m/hR5AHEWbu333ltN73aSKKE4dlvY0jL3sT1DrSGw
         q1r2LCFgY+hcHVX01jSnzF1UHN2VRW5pTzFlPbYPgqM0jwPL26m5uVapWkxVCa+mIt2D
         bGPQm5I5XdgU4wnOHck/9WmP+sJDwPPLWt8+kp8vCwDcCqIALuF0YvJi4BWkLSpziajf
         4IJVdvNBJwOLpFuhrOZhfA01mUj3F7LNdByWayVKrepxEVUEiNtgUXCR3MV2RxKfta++
         9nKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790832553; x=1791437353;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7De1psM/c0Th/SkbusqTwWz8XUB0UL58xuHCpdo1fQ=;
        b=uy2Ww35r3tM3Y+5ysiowagOuR47M0oMdHzLBWsgLBxHOZnZDylWPHQ2IDpxnwjU8pr
         uDZzH5qKWNjbjwvAgAspI83MA7s8cOlOnOnyrYckVNponhzPSFiSuBt0OgAkWQvBuw0I
         c11z9JGm+TtvJ8mfT25ZQNBYjS/usiqw/4exApz2a90UJByRCDh4PMTKNrVWmUO+pP+P
         ICMv64rRUdLKcnLk36H/4ls3MEJneNZI06KtEaOU2F5dG9YkPIfIm3kraKiQPzHaTQzo
         4ZDsOxFmRJHucgnTV1E7gx9LubpOBIlvhYe8TAYjiOLCajNWj4X/HOWhv+wD11YP/a24
         7DKA==
X-Forwarded-Encrypted: i=1; AKwUvBxv5gMpZ0hNdbuvTBIquqb47SIIIACPK9P7jxeM7rrhLJ6AdlyBffVxGASe/TxYe4BvJJxx3g0=@vger.kernel.org
X-Gm-Message-State: AFq9FYILJSFTFg7hkY+4DQtulcuA5BFMizymBqgiryH4DED0RmS1hluz
	+jctcx525zBRoNTToGzbA04IsLiUJNWEllWtFJLUA33a6hCoD6ccw8i+
X-Gm-Gg: AYBFou2U/oO7P2tt3FST2H9we0N4x2n60V1V0FSXmYMJ2jCNiOT6TMu/cH7iDz96+j9
	0UYHk2OIn0rQM5ThVRp13LUjn8M+ww+aUuzvCto/JnnLllt0Pw/ng+lg+GcAiskpeOobDAGmLoH
	MdSl/4W9UGO9Svi3tP3fEMAVzwHa0VmKY7C+uv/6C0ndNisz5StFgEBMS8eGktYNC2/+dXxExiT
	7VdjFUkarHe2dfhbsuYt/nOCx+DbtlYYpu5tyudH1HxrF/XIq5ij081r0V19uPOfrBlnsTRNQui
	PjbQ/fNGF95kNXX+utvWhKWIMUa/i+3uWzJMSeM31oeD7Zk35be88SF9eHAsMjn2UmSA5n+RW6b
	6fw1i14W1OvYDuoZIXrq7w9l2gM1Kcwl2PPUX2qa8yNiLvKdhCg5XsVGaCSOd0KILdY+nEj0r9E
	lAxOqcsxj4Qq3dIzJmvKChK4r9ErOcvJixGD9L1E0Iide8eWMvpVgP6Diq5LACGztW9j2/hr3X/
	RvPgGLUtaZfvW96JxPsYPkwi9sw9RLkmJJDUifleWv/CdzyOzJZTruV/mIxKILtK5+22BN4CVD0
	0yffxVTCYIiFXiVxSNLzovEDwLsl0mzkH+y+xxSBnDsz6BbP+HY=
X-Received: by 2002:a05:6000:310d:b0:485:8c16:a32d with SMTP id ffacd0b85a97d-48b0250afc2mr6371735f8f.34.1790832553332;
        Wed, 30 Sep 2026 22:29:13 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-095-117-056-101.95.117.pool.telefonica.de. [95.117.56.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0691c4c4sm4635535f8f.22.2026.09.30.22.29.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 22:29:12 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 436/877] macsec: inherit lower devices TSO limits when offloading
Date: Thu,  1 Oct 2026 07:27:46 +0200
Message-Id: <20261001052746.76669-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260930152424.092713670@linuxfoundation.org>
References: <20260930152414.738996857@linuxfoundation.org> <20260930152424.092713670@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I object to this patch as queued. The backport is missing prerequisite
f29d24a2106a ("macsec: clean up local variables in macsec_notify"), so
NETDEV_FEAT_CHANGE dereferences an uninitialized rxd.

Clang 21 reports this in an allmodconfig W=1 build:

  warning: variable 'rxd' is uninitialized when used here
           [-Wuninitialized]

In QEMU, the exact review tip f4ffa8dc360b hits a NULL-pointer oops at
macsec_notify+0x130/0x1e0. With f29d24a2106a applied before this patch,
the same test passes and the MACsec device inherits the changed TSO
limits. A three-device test covering feature changes, MTU changes,
down/up, and unregister also passes. The corrected file builds cleanly
with Clang W=1.

Please add the prerequisite before this patch.

An LLM agent assisted with the review and QEMU A/B testing.

Thanks,
Karl
