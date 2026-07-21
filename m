Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54710F1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595402; cv=none; b=GU9HNjS0P+DZ4HZWl9/PaAdOVqdJQZx6JC5GNLZEcrsDHjK0MiTwKnOk2Ilidk592RZXr1iGB9uqx/DAGUvViGXaYqbuC1mspwW2kplYEHYX4LZ6aunScoQuSxeRNX1LoYR05ZjrI+lxSrFPV82Cs8LBcXpVheLesaBSxfs4x+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595402; c=relaxed/simple;
	bh=6hbSxLzgOAaNlqPsjuQOdeJRJPblu1XK7iqPAZWz7Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbfJp8WCv3GTx2qkk9UPqvYWbvivXf7dWiwZBlvdwXPTSNS28Vm6+liiEHZ3cx03erEPyYCD8BB0rR812o8Jm4KXLkLK0/9BoguvudJut05rxcKI6FHXGmRTLjG8p0zuEKYUEQfIrCqSdrSNxtYwsO2TxMCArJRaZGbjtWZHbqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xoj9EWMZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xoj9EWMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A231F00A3E;
	Tue, 21 Jul 2026 00:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595401;
	bh=11oUEruzKgtnJ4/Oj8hFCkYRP2lQlVU4PfptXdon944=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xoj9EWMZU7XGWXjEgwiqCnlbVwMPMbibJ6244dCQjaKzFRyG7lS+AT58jLRs7fU7z
	 Vx+I0jEKsm6SscxOCy5arci+z2sUPQl25g+cGhled6cY1zCjtvM6kCqJWdb0dYFiIP
	 FbtutT6GNLbncZ2xQXYV7pHfT+VBZq+upkYutx3SUt2504PU7rQXvgrdEK7eRWZD8p
	 t1Sjw8vi7wBF8FiAgLE5I5La+qVOrJ8vh07rZbQa2ZQO9t83K+PFl/BKtangOVLDNA
	 0pNuBvyJRuBuz8GBxcc2NeIvYAhXgxd0yvKzvp9GMwodH0rSxsrvCaqOAZgVk3GbsN
	 CcqB1zCj7XYsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.6.y] batman-adv: retrieve ethhdr after potential skb realloc on RX
Date: Mon, 20 Jul 2026 20:56:14 -0400
Message-ID: <20260720175500.0007-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720132056.176231-1-sven@narfation.org>
References: <20260720132056.176231-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> pskb_may_pull() in batadv_interface_rx() could reallocate the buffer behind
> the skb. Variables which were pointing to the old buffer need to be
> reassigned to avoid an use-after-free.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
