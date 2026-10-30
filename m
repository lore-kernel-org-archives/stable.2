Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363084;
	b=2BKfveEeVcgRAlL1HTuQ9cX6VGOaG4ZoIEL9+sOaCJgGYCLoq9f/jZQTsI9JLt1elNl6
	 /RKqnrelirWIgjvoULz/T+aY9J8G0pyP3tCf/l7citFaz5MMWFlsS3AJreIctiCvfuuAF
	 B41BsU3izJ90B8LjL9CFPZbho/3Q7KRK2WaAxIM/IL7Z6+BbzTKbfmu6u3qfyTvfOF61F
	 2314s7hc5hYMeAe1p9F1E7Qqwvc0r6GfcS4bjG60rhlW4N+VWEpCrHgYmeV7JCg4mBLGg
	 0UMl/RWY4GdcHHve9Z7yO2pcHC4slnFG1yEL8XazF6g9YqTHJj1AfrD3BcnrAoFy4VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+yrymDp79FZjbqEueI9kZqfriu2oDHzO0g8H9zdbK7E=;
	b=rVF6ulUxBs/XEhBy9dP2H/7M+EHnfi/MH7JQgpZySe/YdOyRY3/GCBlOI8WZcYrD2woB
	 xaSYGCxc2yPdViuQoYifxePuE2c4N6l4F393QewYW1mGU7rFwCtXYFMwbZnfB7KF4Q4iI
	 gm6+NyTFcgJhi6vlRdlLP/0GCiz/UAG5cX6IahOUNtHDNxyYSZu7JczjGHj1AYFybjLGN
	 o58paWDPO6hPy4pw697ImuckXJOe377JbP/5a42FWig0m1LG6gQbk1igu3d71EbZwSqFJ
	 MhB30ocXau/4CBBepgBSNBMTZynv4wKeQf4GOpT5DaW7TzWqhomwL53P8X0QExNopbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kDl7HVvK;
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638B606A320
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 12:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9638B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kDl7HVvK
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cdac0ac5f19so340823a12.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793363083; x=1793967883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+yrymDp79FZjbqEueI9kZqfriu2oDHzO0g8H9zdbK7E=;
        b=kDl7HVvKhavC8dBhxopELEbRq96LLaI6slGnuyyzzpW6HiVfGW+5iNPWoH9zW/heUE
         w8JVowdf9BDkIaRkb7XkvY6hKwgR0yzPfsDWcGZ/TEK3ir2aGz2DFMTmEl5ZhJjIRj65
         IaYA3vc9JbhxAqMO4AE7rw37++O1oUWN3Nmqcedd8UaAiPLTaFv3cdQA9uxOBqo02BDu
         ss3CrAEcE9GJBCtpgMGVvQtPYxRYHv/K46Bxi/obXBWgOIplzdfvA+5nCQS18C+R5zJo
         1LWEf+wYAQtEBy64hU04DLZ9zd58muabV/fqQF+M8lsvlA7BwXW74bgmo1u6xwlDDvrO
         Yo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793363083; x=1793967883;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+yrymDp79FZjbqEueI9kZqfriu2oDHzO0g8H9zdbK7E=;
        b=I6w3xPzqTif6HSqehcddMLUEzgvlaRTPylqnOzc8D7zwSxNpA0WjZ8ziH6erTtkj3s
         vZKn8lJDd+Jaak3ktRDmkUq2Z9imYgyXhQkFxcOIvG0UQXFXw4mChAl1CRXx5rcq1xOX
         y46q0xGclly5akvTDMDkJ6hvyc4mT8bwnYJaUGs2h3FXDaBplX2rHsUb4GMym9qcmSw3
         cVQ8Lm2+hP5IXY1XTu6WER46jiMBZtaF5jd35YXDHhlNbuHk3+0eJ3vVNDGkvFVaLJ5E
         KEvDN6amFxwk1f5bVuZnP1552VdKBVmaR5VpQKnWJ5Ry07NFHhH/t9olaJmDXNHrUhol
         BPdQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOE9LcygJ3Sh7Jjq7Ryui6qCrn/1xzgqFEoHV0NuFyNNUKLt3ul6kYrhOnufksUujyKFDs/Zo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIILeOZWDSOq5ydL7s4PMjK1gQTdbeccvyWbJtLJ0ZUe59JUQ9
	vkln+aTMQKDO4ydo9Vutjpr+xj7zUEncgnlRY9rm/jIR4Fupm7Johptf
X-Gm-Gg: AYBFou3kl3QYMKqQ30n0J/8C1psnIfPI/lkFaqiUHwUcJVGlC4Tb4QP0G2U+NOsE4Dw
	8aXLpiplztgmEqS5WFubfNGCBswKHRIPgsJZpa7SsH7cyJSllVdXf2guvEUIOAzQm9YpxYn3qcM
	ghmxcbumYbzQUMVjNusiEJjIijsm1jCDXuKJOnSjsQS3M0/oynjbULA9YQbVCSuAHT1sRKjYcOr
	q5a6gL4fYBMg5hsWDOB9/pjuF5weEIA9qXt5K+kf0BYiVvEDzjpYloQjUULZH8RSfwGaqklW/gN
	rpYk9vCxPd4vH7cNptXs5snFBJdSoPrvMB1rvvPe+C4e/7n6QLHu8iT4j7bceS/c2uAR29p6Zlx
	yQiG42kyFsu9gfA0vpnFWLiViZKvTdG9LU5e/fKHYjqEMjai+BgrLqpqePmhYa+u1cAuWLIR2+E
	ngt1y8W7h1k5sO2IUEns5POJ4p63OVFo6lHlMmde8qKzflcUsJCQ6w/2CWziGUmQEJ1g6yeMqx7
	eMD2GEUTi7jZxzbFRBD9FMvhvhtod2XOHXqYJgW4xNpwAEbdv4BtTNcpGweVOXAbo/OXxmS71V2
	AS1DG4XrTyNWykONPzpwD8oBrJpXF4TGacCzA55pjM9VAUK4WK+oHiWuqA==
X-Received: by 2002:a05:6a00:2d85:b0:873:f7a4:433f with SMTP id d2e1a72fcca58-8a9bea6ad35mr1985118b3a.26.1793363082777;
        Fri, 30 Oct 2026 05:24:42 -0700 (PDT)
Received: from 192.168.1.3 ([2409:8a1e:2331:2850:d40c:1fcf:6319:8524])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9ef56b38dsm687929b3a.31.2026.10.30.05.24.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 05:24:42 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	netdev@vger.kernel.org,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
Date: Fri, 30 Oct 2026 20:24:34 +0800
Message-Id: <20261030122434.91530-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <auSF/bDmOW0Y7T4D@boxer>
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com> <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com> <20261030084017.16202-1-testwrzwrz@gmail.com> <CAL+tcoBThTe7299eVU=tsUdi392dS9cioXX5RA5AKRsYAGbdVg@mail.gmail.com> <20261030094633.27910-1-testwrzwrz@gmail.com> <auSF/bDmOW0Y7T4D@boxer>
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

Thanks for the review, the suggestions, and the Reviewed-by on 2/2.

> Can you stop removing all the previous conversations and rather reply
> inline to related paragraphs?

Sorry, I'll reply inline from now on.

> I don't think v5 is necessary. And as Jason said you received 3 review/ack
> tags and none of them got included in v4.

You're right. v4 went out before Jason's tag arrived, and I missed the
other two tags from v3. Since you don't think v5 is necessary, I won't
send one; if there is another revision, I'll carry all the tags.

I learned a lot from this patch and from the review feedback. I'll be more
careful with future patches and wait longer for reviewers' feedback before
sending the next version.
