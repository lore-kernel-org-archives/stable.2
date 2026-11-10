Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323162;
	b=fRMRNwWhvuLLh21y+g3t1AafigYJtIIpNykK2hIXAukT3FHFNhPFadhUz3vWDYrN6kYE
	 QzvsrkIXAHraNrurIvdKCllCx6MQl5OJvdc6DcqUIhAe5figrb5SBGeV8p5CUc6Zz4dGk
	 7+c3vkzTXNwsBbnwHkMXPlt9oZM9wkhls37HaZlY3KRepga9Hhu0iSU3RiOHzqMJKmrHj
	 wKcF/qtniB6B9nex5n7HoSxMwHcPdy3r3X/WFGRaMbq3ojtkvQVMNbIsQ1nV3OSvB46Bl
	 QIzSvuL+jbssxccoiUwCYAw6PzzKjA5zOtrheFVvPbf5Ex+VXK+s78NmJnsAulz9+KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gtuFbnjq2nLVxWsBMNwvdFWZfdEcSneo8/sCYH2q1Y4=;
	b=KEFtE3+0p+W8ijgr4kBCXUpJmRw2T3cZYgMnYV89RUDTIyOYDR7Z+nFe9WU+0Uc9pP6j
	 ZpbtaSxKzeNk3s1hZbUzxScmkG+yzjc5ULWzbMhiiNfsNglI7k8EJkwuCmMPWUZ4NGzwv
	 B8QpFqYaaPGJtPz1r+KOuvqPvZGd4qKH4o+Gg7WzzYfAPLi2S4DpgScQV8BFjURqW3yqV
	 u2P1QE4FTgebKB3yiRmtP5ZmsMrXek1UCqunvGe5S3AjU/DEnZEqkLbiaLRCjhgOVsdT0
	 Ee4EDPrsuCJvT5IxGIUO+39YZKyc7vXy8at2jLO9swE5M0zvKjAOUNs8susML0In0eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pnD4qUJd;
	arc=none smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5C606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27D5C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pnD4qUJd
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c14f3dab66so2097871e87.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323160; x=1794927960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gtuFbnjq2nLVxWsBMNwvdFWZfdEcSneo8/sCYH2q1Y4=;
        b=pnD4qUJdtOtsCAefLq/3o9uDiViNB5gdPwIS8ZPsNuUk3SvkneLb6tYtvpzdYMLb8p
         4xJzOr3MPWedRIJnbdXdglpocNGitoDXuDQQfLzgC4fhv31hbTh/7DVVr38E9En+cUo+
         P1vf4qWO0tqyPjoYDrTHvqn0TrjkTe8XF+AXh30vnXksbPO3NLsLIlRgU1ftku5UDBHW
         A4sqP4tiiUOdLydoYOSR0Wj/MZsAVPbgin16PQsC9kPq8D1o07dKI2rgSkO8KAYopglp
         e2elM2rPi5p8fwv53HExfilPbUlaOSsyFb09bcOGJ0QlX/DaTahKTcu0xQAv41KkX/mm
         adGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323160; x=1794927960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gtuFbnjq2nLVxWsBMNwvdFWZfdEcSneo8/sCYH2q1Y4=;
        b=TX1oebzGedOj58/9qwmsoLxGVPYvbnMnsyxUq8xBBFWqjQdeksHanibtqFmq28fg7h
         tbfoj80mKBwtxElZ9+jUQB41eakMgqYDp07ZwwiJv2Rbgps/GWIOLcczuGcmcIX6+sJ9
         HO1+8jupSz/hEshTVNJdWCP4qbPavXzj00vgexts6hoNVDq9lN96wywevuMhd6s9SCPi
         f6eOBpTuIVP2DCL41VDAnbpWIUcqdNZgkNlBvyFSLqmkzL2wQzImVIGB9CWRcJZsfrq4
         dnTPJiLC1F8p23sw/Mvu1MyHeTIwxM+1jZzMc9kCrIJ1UHCIlBWse1eP6ZhmidBmWb0d
         XSAg==
X-Forwarded-Encrypted: i=1; AL+hErFz49t4zj/iLQBYgImstBf/Oqux3GMVl+0Tr1LrSPi8j6i4KNON60gXP7C69x37YexQuz7BF7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/PHR5vqaUpEMfsiABUZ4e2OoDiq2Ou/TtfwUZzf1UsPdPzUFL
	+7n8VdpCsFKsxl1IalzlV9Fkig6/v1cw/Tq45Wv62T7m5A08qOfCg0ntuZ8E1g==
X-Gm-Gg: AYBFou3z6bdTBQzucWbdBtmouWiutd1op8MCCRtO1tunGtSodAlBQb/29iXji6gNhPM
	3pAAWohnGiGCc6cBmHqEfCNF8vGJQ3XEHPniOnUdeXx7NyGbmZaIC4IAhW9hQ/LFiO4dQmXFdia
	AoyJT+9+rdJm5qnoPYJ7ufi2aZoiik+K8/sgL4nJU37rjLNPHigE54DOGVVsHfum1uh2fS+/QWn
	FxJZ38+kxhATJsQYHgzydnrQxWk0+a9+04biWSfd7qKPLOxA71LfM9cO1tr2UFY1Bjn/GlWl8xT
	l+/6Vt0dXDc3ia7DZ2wtZl+diJL9vdLUaHunMoeaKSX7W3VlSq0oD/QFG237DbhAEXNLCiKKHPc
	piKTOGZk5ZhRF0OR43u2yhKrafuLM8LqTaTF7dlT7huLfESVCb6LggH6SPf+Ak2BceW8yKfir6M
	HJfo/M7UHgtt8v7RCixiLv5tbeiBWTQsMu/6Jq02xztGR64bETqjGFKazc1MR+ACkfz4AqXwg0u
	mZVgNF5kpBVSbAW35CSvCcX+UNAS6yA+LTn04Z1CRckBB3qBtsa4LwYcIiXysWATfkjqPDDuejC
	9U6GL7J/82bbAjsZfDD9+cFGVpMPsr2EnTKIq56pFXM+CG6sQE6HwT9nFUn9GSls/2UgYHeRHK9
	dv0VIRJgYRFNeyuQXzl9TttsNAzWJP+1LtWOuBJQ=
X-Received: by 2002:a05:6512:2288:b0:5c1:56fa:95b5 with SMTP id 2adb3069b0e04-5c156fa9775mr770768e87.21.1794323160080;
        Tue, 10 Nov 2026 07:06:00 -0800 (PST)
Received: from yantra.. (nekmmqt3kfwnocz4ivv-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:453b:19fe:80e1:2b9b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157b7a13esm475253e87.2.2026.11.10.07.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:05:58 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: sashal@kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] iio: pressure: dps310: fix CFG_REG bit definitions" failed to apply to 6.18-stable tree
Date: Tue, 10 Nov 2026 17:05:49 +0200
Message-ID: <20261110150549.13900-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107050735-failed-6.18-4334dc4092c2@kernel.org>
References: <20261107050735-failed-6.18-4334dc4092c2@kernel.org>
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

On Sat, 07 Nov 2026 05:07:35 -0500
Sasha Levin <sashal@kernel.org> wrote:

> The patch below does not apply to the 6.18-stable tree.

It applies for me. git cherry-pick -x 4334dc4092c2 is clean on
6.18.62, 6.12.116, 6.6.162, 6.1.192, 5.15.225 and 5.10.274.

Could you queue it for all six?

Rupesh
