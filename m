Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349627;
	b=SviHkoP4UmdLuJNC3BffJaHnnXdUi9ae5BSitMpmN3z8gCC4ijCQSwVVRzb6MsRI+/ft
	 /laPwrbjRIpgTjK2uJ3A1WI0Hivu2K4Di2wNbDNjEl5ij4E+2RiFdL0NYBvkmVy+hPC2z
	 cwGJgy8YQpJqShadW7mwM6SZ6WwQbBz+XUDTILMxCyFeW5nH7cf7rOH3fFk3bpGfqUwP1
	 C0kDzZwNn0T8Ol3VSkAvmQi5LojpIiEAIPAfK/jE9R5EOHJPGlEm64R23ejfUA4veiFLu
	 92xBdi0lYL0Alnc92DT88YoSU/QkIOPSJjYJE7VRbMFcorPCg95AdMPra5WUzxjyHng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=p2lbErXysC5keIICd/9Oecm+satsW+gqAIlkh7mZJ8M=;
	b=VjBhwsWUuehAQkqxsTI7PQa38Nxjepu7YbUyFEUJw15BxfIVCHrYsXNKKZkGvJqRHIOe
	 5zli3SVoezFHBvxtvOfuST/Lm52ujKYEu/HynLVic2+UQQO/ztPQiD5mF95xoLyv+r/iT
	 sPTu9iPVvmpXToW36FpvmDr+k69afuYDj4AGeFQiZDxNkEgMOsweIj03QlMKSx7B1mFVK
	 wUr219xrkjJLyplv3YddSAsMdnuyLGFWX4ycpFIJ31NE5xYzhJR0idSFYoDIv71qo6rn3
	 /8Q/3HodcPdUC5apZ3SaTzo9wgiw+SqZFnyUNlnTn2giT9nk8E8KLwYxMJj1zm9J4Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hwGefDb1;
	arc=none smtp.remote-ip=74.125.228.6
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64D606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC64D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hwGefDb1
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cd61053473aso8278a12.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793349626; x=1793954426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p2lbErXysC5keIICd/9Oecm+satsW+gqAIlkh7mZJ8M=;
        b=hwGefDb1SWctrOe6SQdKvltFiVhjCBvK4nzZjKCLo7KEWh0S1Zef9SO464ErUQOnLK
         8FjZ1sDDtHIsonQIgKxdTbLw4uIwlQi2nGAu4hwzz932I4/O5msW4V89rV0kqfPaLFRU
         ZOMZ4hAF3PZ+bdVnT6jOMAnlLN0O6O2bNyLkCE38yNOTsQb+5ERP3XhcxZTbgSh8SEzT
         /gGQsfwAVL7tr+QOnNY7VjxbAkKIfyvzEwF8oaJytuHFBdkInK5U+5Jg6sYYnc4Yqwjo
         jNeC6Qp9fJRlf3KL++vTrCllFwypFsOFxMglcQOeCJww6ajRJy0ioYfNOuXNSBojxPhi
         gQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349626; x=1793954426;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2lbErXysC5keIICd/9Oecm+satsW+gqAIlkh7mZJ8M=;
        b=MOKM4YecpfuLfp8FRaE0cg/kgvZTlU8MikR13PeLeg/b9j9N7SYXK/aWhzdfzE2JHN
         hvFTHywzpFOkB7cZ6D2LuMq3DL9CbfJNQ9ht92TZDoNggYAZJu9arHMo8UXW92AA+q3D
         hpGsHVLshvk9ICYzu6Lx4PRWtWwGkinVkhH640ZLgm6vhIHzgkCKbr/qEQYx+xf5aQIW
         3RRCtD7Mh7k6b+zaRyOxR8iD7bO3dGtxiO3Z7dYYmU5MMI4YTjRsF8TwOFhrraAKvZqw
         4I6p+oLFMxwBvolOaRd4vfMuBdvmqPCYwmQ8byfEqYAtdDdtMKO67DNlg1XXjgS6ROdT
         o7pg==
X-Forwarded-Encrypted: i=1; AKwUvBwnjloMxhmcYPiNe2t+zfxpMJ4RwxHPTYRnTiNPbmo7xiIH3m1nYILSVP+kvEFINKPdiyLLhO4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFcHw5azeqhkOw1WVggubqlM0BWxRPr+65QB7QF8PvpVgT5gU3
	wxAc5wZ0l+oJX5BLHZsc8KYxBiM4ZNlBi4GeONZs7qQZpHw19mVnWUXw
X-Gm-Gg: AYBFou0MpIzvJKGwhKA9S+E1wX0R/Aut3wiS2C8WbAJLoWytMtDt/epwhf4i7t+4nYx
	VUSJXELUe8kM6fJyklXXQeEDYxJZc6BGZZI0K1mtBwK1Lxdb0l+UBN0wQzPoxpKoPnoP7VYthuS
	L9IQOywFfqtV6B4jTG8S6CwFCTACWmEr/Zl5PE6W/eI1IOm1BXoSb1J8JZmJLsuXp62lbc+zTeP
	MUZTozbsprU/dw+ISLCBPkKBcPhmWNVwAIoC1OOpnHm4zx0aTQOqya/1x9Lm86JfSKNv9k7eICW
	bFyon2HsSWTK9X17CCpyK59PjHaER4PU879BnsIGlawp4lIcswgRTgjZ6dxx7C8ZDQY8SNDUPAL
	U6S6lGGPPSMbAPi9vBXI83ZHicwgT0gsDxFfyPJAeM8UBovpFaHDjdFu0Vakk+Oy8CSye4f6IMP
	Rp0ovAJT/qnHtOY4Fiy4DHB/IIJWhtq7xeOxZ9/DVA3jmzECA7jPrkcRF/JBup3BAe8wbYemvOq
	7hyILWkVERnTnlLWQxqcdPn8plN7FgYV5bH5uUOYTqIm2AxeSNHNDM0/X873DHde7yZmI4ZFpC2
	9z0ZN7BHhKLqjjJdv6mFCw7XWZasY/zEk81RsF6mRloil1/AJzLUHX7+tPM4mmY=
X-Received: by 2002:a05:6a20:2586:b0:3e1:9071:acb2 with SMTP id adf61e73a8af0-3e928a0b0bbmr1315570637.33.1793349626005;
        Fri, 30 Oct 2026 01:40:26 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2600:2f3f:1d83:9185:c6a1:9ca1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eef96e53sm486051b3a.20.2026.10.30.01.40.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 01:40:25 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
Date: Fri, 30 Oct 2026 16:40:17 +0800
Message-Id: <20261030084017.16202-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com> <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com>
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

Hi Jason,

Thanks for the review. This was a timing race, not intentional: your v3
reply (the Reviewed-by plus the else-branch nit) arrived at 10:30, while
v4 was sent at 10:32 and had already been prepared without it. I should
have checked the thread before sending.

I'll send a v5 as a new thread with the unnecessary else removed, exactly
as you suggested, and your Reviewed-by carried on patch 1. Patch 2 is
unchanged.

Thanks,
Rongzheng
