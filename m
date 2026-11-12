Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507548;
	b=PkCHvE97dWyFh4dTvb/Qex+8H0mmN6Jw0rG+FOu+5PVxo3kFJ+dPOqsGNbkmafa5UEgP
	 lgDlfuYX5LWSYWvSMZPMrkOMsXsbi3VI+xwB25+0C75O5c0JV+FPy/xq68olEiT9OVhO2
	 5uY9ZmnMtFgla9zx7WnBoOuxBqz58aWmstrqqTyZ0Zw5MeBrLRj8YvPNN7vJLr0lFTqJk
	 rexIdzWBvC4sGHzarlCMclP/EmXrHP2QLWPBw8ncgdrBI2EbmP5uCcxDd9kPXzdOTbOR1
	 mqwdX/RTEUlSWQomBpi+kJ/ANd00YCGcxcVk6CJ7iY/cYvE+PCZNtUHeN8PROq78+fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hB0gGU6/Wvj6DY1CIjnvdF3luMseLxUER3Q6hRYFMuA=;
	b=XLTAfD5d8cywPpqf4PaIpAebNC+cTYvbF+Qcl0Usm9HCfm4k7EN/qCyIFEmdJGRqp3u1
	 4A6kHfepj+VxNGo9eiq/NWUfiWPvoHVBdfnIE153y15COpRrGVAJpTiigFINarTlNpRcy
	 LJJ5vZMjd+Pi7rhazExuGSflgaSfRBJC/CxtvVjjCrbeOdOBAUhiJhFnZrf0NieuXR8oU
	 KKzNBFKz5X5VmYdfzRMRQS6Cee/sIvB0frOAwiZrR9XQx+v8cCnLkZC2Q/ZJu2+qU5bSr
	 nGH2aMaeluWwQQ0nOkaKDyIXWpWcVpAW80arHMV0gx1GT/GyHs8fXDr3o10d3aQVWwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aEzGzzhe;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ACA606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78ACA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aEzGzzhe
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so879235e9.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794507547; x=1795112347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hB0gGU6/Wvj6DY1CIjnvdF3luMseLxUER3Q6hRYFMuA=;
        b=aEzGzzhe6EMFNOvAc8cfQlCBSeL+1K/zjWgyK5EZg0KOfXRvCTDR37DN6Dvaxui9Jy
         kEyTMJCIJoM3sImYaAyUCu/k9QIQwhVdoS90OalO4Hs4hhRPcJEvLB09db+cU40pUXV5
         drlxgDiARYvqvqh1fag3LhNQw1dMaZ2wnvqMS8k1R13dcPnLeiOXlKWwqjtgWblmifpq
         y/WADavmJRtrqONZx6E2ynDb0r5XYhApsRbz2dpQ8JMe4c6RiphErUvuVS4pd0LxTRK5
         DrMPuN4QUkEl1rpwRIn6qwWSb1mJQz2GPIgQboD3O5JNtxt137JkEgUXNCiYp8pr5GPs
         d4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507547; x=1795112347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hB0gGU6/Wvj6DY1CIjnvdF3luMseLxUER3Q6hRYFMuA=;
        b=jxQ8WqW3scsqg5b2Hvh/ACUMhV0esCaKGCbpAuhhRskF7C2KE0jbn6KN6Pq9cpErVe
         MpsTzQocFnYV385D0+cZmFK+P5oQhtHjwrDlnnPWKjg9UQeQp54UL4KrH7pnSlqR0QO8
         HAdNJOWYtohuaZjLtPYcl/tWvksmQoI7+KAsfOOtrV91ZFpGOXYtgF0QoX+ppkghdv6y
         QR8v4yk37J14nfE7Y/3FsqrUfbWiR99nuTXh7OR4XbqvsCQoDwLivjim1moYyHysOH08
         uDhmChzRbve2f4c8/L9bab8SvJyhccYrVz9gGe2Pc2YvY24bX5WccKq0hmHBj5NhNhRF
         dMlg==
X-Forwarded-Encrypted: i=1; AL+hErHV3Rn5IrHSQM/pTTJFB8GgoXfzS+aHrT/gVvlgWnBKHtTWUC4sShuLrraYbwP85n7tf8ySJpU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KQjpTwPtONqsSXjZ/Mf668n2Bm/G8zmsKTAp9a734JN0+LqdW
	BtKjixtYiJiomKocmgBakFWk6koLY4MK2LnCRY5i7X8syJ4US9vp87/s
X-Gm-Gg: AYBFou019UlcLhziFb5vIme/A0KOxQBjtq7JLdYlNeh4e+DYSC2lbOrmgytyAcCiOD5
	zFtvjrQ/68vjkncpo4lntBeXv9LdV8lhDa7spDIM5WWMDV9I+0G+v2QIdbSdrq+kCj2TsZKl0n/
	tpAip5uDexlUehM+nikj0bR8XdZpSCdTSwFkaMMoLImr5dIeWC97lyauKn6jEaC50IK5FwzgQkB
	B8zvaz2LHVyjrqj8Pvf4L8ntRj1NqDOFPGOQO9cArCqtG3aScaXGQjQtpu3IbEt08lUp8QbnMI4
	gyYh1jL8ZqShto+J/7V5mKQ0FZAZR4Kz+t/X+yANpUhvNwaloMQp65ITohgXjLyfDNJj21bX6w3
	BVJGb0w1p0vT058DrSXIYByxf8kAH1D06Hd27Y8+H708GSottrCve25NDlYcfq6dmZLXs0h08lx
	/k9/xSejR2CskLj76K0OgQ2QWCCkNUfkEXowK2DxCyixg4s9gkr8TlnH8apSRAHgX/m5cac45Ip
	6ChBMAv1QmN/u26VghhKpmRmmgywBbxOoacu9nbb4xc4Z9uX4U6nJRHU7zoyom0ICgbVl2ghwga
	7Q2S/WtI5JeQaXZbrwPwyNd+VshgKv8cbL+lemtTHxKCYfFxgKTEpn83pRdPqXYoVUnhsRyUOj1
	7SA==
X-Received: by 2002:a05:600c:1912:b0:4a1:c5eb:b445 with SMTP id 5b1f17b1804b1-4bb55ad45admr76185e9.35.1794507546798;
        Thu, 12 Nov 2026 10:19:06 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.56.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e27a8b0sm87629935e9.15.2026.11.12.10.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:19:06 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] livepatch: Fix races between stack check and module load/unload
Date: Thu, 12 Nov 2026 19:18:55 +0100
Message-ID: <20261112181856.234172-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avX8UWAA4DN44p6o@pathway.suse.cz>
References: <20261022134433.3595212-1-parri.andrea@gmail.com> <avX8UWAA4DN44p6o@pathway.suse.cz>
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

Hi Petr,

On Thu, Nov 12, 2026 at 06:50:09PM +0100, Petr Mladek wrote:
> I am sorry once again for the late reply. I hope that you still might
> be able to handle the feedback and eventually test the simplified patch.

I'm not planning to pursue this further, so there won't be a v3 from me.
I'd be happy to see you, or anybody else interested, pick this work up:
please feel free to reuse any part of v1, v2 and of the reproducer.

Thanks,
  Andrea
