Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ECA3A7833
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103121; cv=none; b=sf6oWoAfTXiDMyEJ9RjQzsCUQZABByUXxTYSCVeMf40FZRLOSEo8SeCxyrm18M84nMOBAn4s9fOfCJfe843VqgRryi0jf8LmZc6WJARTux0wznTVy0pEhHVgVQq/uBS9XVJ33DozNRfzEagq+bjcERLo23CW+pB19pBFGapzEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103121; c=relaxed/simple;
	bh=p0b2ojC8JMYK3bKJBbFmi4xpUQZGrgyJaUqjbAB/nug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDfxm1i0a2swYWU/xDNug4Y07SwSsT4dgnYxiAEU8AXvyHOjcPjfNj53+GDR47AY+aEd59p9rEX12PLCsIU7pPX91XuWuD5gWyPXMhXZrZN8uOTw/QhjKkDxvQVCkaxImNA9HJfl6mwI91Q8dQfzjsZcgmXY7gkauu4abhFKXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDKiYBK1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDKiYBK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF9A1F00A3A;
	Fri,  7 Aug 2026 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103110;
	bh=vmUGIA4DEHP8ZLGSGSnG7A9+LsonHN9GcvRKE84gPj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TDKiYBK1xXWS8QoeJPonrvjzeYhVz0kqQdxyHQCBYbly0Lq5kXV6laKvdmgId5Ymm
	 Rk5NPBAXHvlpon4J2PT2sRb8vuUSQpTmaewdVswWxIO751wHaEMQtZCVPQNtUHaG2+
	 /W9EDRayFszSXbOwzGmCPyBTIYMfkcFw1dTyT40EnZqM/0tNB1HSSMQuV0cR8YEb87
	 gjU3MlFbr6VAa6xSZQTqsEiG1sjNvlmrXL22b0VBIw+v6FaR+A6YGTOnc0iqCwpvP5
	 pjA4aDE/7mJXSd/8QxAChsqH3c7NsV8RNUEOwrIvLt8XK7h7n7FABuIl1yCssaLWf+
	 z5NfdYQb1xWQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kernel-team@android.com,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marco Elver <elver@google.com>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 6.1.y] Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref
Date: Fri,  7 Aug 2026 07:45:06 -0400
Message-ID: <20260806234001.stable-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806005214.179730-1-tkjos@google.com>
References: <20260806005214.179730-1-tkjos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 12:52:14AM +0000, Todd Kjos wrote:
> l2cap_chan_timeout() runs asynchronously and accesses chan->conn. If
> the connection is torn down while the timer is running or pending,
> chan->conn can be freed, leading to a use-after-free when the timer
> worker attempts to lock conn->lock:

Queued for 6.1, thanks :)

-- 
Thanks,
Sasha
