Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792464021;
	b=Y42ii5DgeJq63MDaJqsAMIPcyj8u6bfuDc2amTopoPvgwqndQIe9GoDA6ev1TVfXEwYH
	 R5JhTpXTqBh7sP+GDIC6bxJ0ryBWFuKYPRSlKtkf4iItDqWONWWF1I8k+mEMzTpVtJZN6
	 UBECTeGtw496pbJ5sxQtJia3epihui7SI96oxs6NnYZHtEZO7SEDd5IxZ6Wthh6wnGSoe
	 SEQBXm3ekjoFXIBhg5rENtP40PWA+QOWlqj8zVTHFd8iUI4u3N07XRZptPTZviYbF/6E4
	 /rFlfpNWVBT99brE1477Q79wtqu/U083TTXB0q/eZAbvr6dmJuf4aV6rUOss+vf4NrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792464021;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vpOvmrfomZiOoVefWB3Ka4zXjDuKtTA85d2/JrgL/Dk=;
	b=mGolDIZpDsmN2QXlshJxa/VAUVtSxpMqvrex3aPAIl8bKBFq8AEu2Exo6bflg8a8ArVl
	 y33eiuJ43uhdtMAvuXMaHNHouTQttIMZKgcNwq9vs2osbXVzLwrUH748lVIYZ/o1kc0WQ
	 9YZdhaFZ2LjIRNEleQH/AUfxi0FjxJACj6wpYtAVQFPih+Qtjjag1uRa3jfHcWBZVuKdf
	 iqEdaqB5lfcRRFX84lbRnJh8qSY+vW9vhCYX8qNHZlpbxK0DJxE/Qljh+7jBCSqXZ6Fkq
	 XqAAgjErXG+46dbjpVLNXe2z4h1uBKH2kv+GvvX4XQTtaWkapJ5kXkNwi8L4sCRJ1Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzKtuZa5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96C606A31A;
	Tue, 20 Oct 2026 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzKtuZa5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D261F000C4;
	Tue, 20 Oct 2026 02:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792464020;
	bh=vpOvmrfomZiOoVefWB3Ka4zXjDuKtTA85d2/JrgL/Dk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZzKtuZa5NDJIZm68nqt9q/jA9ffP4Gi4txH9pPNIO7SozsU9DP5uxzs1EDujIFmJ5
	 YrfhINdMyrS5nu7Tjo0j0PwktddgC6AjUbNx768ihR4D5yOeFICyAEHrpzosOje200
	 H8InUIw7dTgSeGRMA6cm/6SdmH0qMfkzGFNKHEfiY0zGXPyB/MnALBF5nYCNUA+2d6
	 BeUxv4zRz+jqIi/Hx+VJYfY39ElHkbMcUeT0/Lksb5UyN82Nxm4LwoKs26j97SD61X
	 y+KitdF9VoC3gyHjIb38Z90vJ91G94xTQupvTEbwjgstLHC055t3n8HesG3E4I7dpq
	 a/AGuweorAPpw==
Date: Mon, 19 Oct 2026 19:40:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, Jiri
 Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2 repost1] net/sched: sch_teql: fix shared
 headroom and header strip on slave retry
Message-ID: <20261019194019.4b778671@kernel.org>
In-Reply-To: <QDISC-6HS9.v1.r1.20261012134711-1@mojatatu.com>
References: <QDISC-6HS9.v1.r1.20261012134711-1@mojatatu.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 14:16:27 -0400 Jamal Hadi Salim wrote:
> Subject: [PATCH net 1/2 repost1] net/sched: sch_teql: fix shared headroom and header strip on slave retry

not correctly threaded, again..
patch 2 should be in reply to patch 1
-- 
pw-bot: cr
