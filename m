Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6F93A48D9
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224317; cv=none; b=Iypnt1H1B3reH0E5OvJvqrmdDCq+LPz79/Pc34dVBLpL/4bhoDUmsXG0BAQqPZ+WrI8SG0wJge07HMOHe+hBjc9QnYsB+ImlI6/rGs+lL3z4k4U9qu/q8xbQ5X8dP505pdL7y+YaH/axcz8WNRSjG8Bxw09UBJhQzLn+5irJp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224317; c=relaxed/simple;
	bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltVO4Mytb0EA7EjRUV0MThwzcoEuRzATcJGIPZUVMnZBlKM8Oha6NoXHHpTrti+Dgwwxd4dffj5sb2G1ZLFRT7rHwIW2cS7464vRqRZcjxCkm5yKU4TOzilScoIZ2cE8wp5nMaDjr4swxrV8UueJXt5jI2B7uNKMovBmw0H+gAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6QUi51w; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6QUi51w"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b2e1d5so909043b3a.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 21:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224315; x=1790829115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=O6QUi51w2N9AjF6xq+I2SOxm3120l5gvM/q2UUuP8ydbXQ7W9DUrrf/X9OMrb5ooHa
         M+jIoQKT8ZrTt83fs/knotPnqrEVCca2rdOa3aXwrf9Y6+R+twDEN2AVfvexhMNwpl2X
         7KUPoPfXj9saP0Dsp0dt284l/kzv6JdUmAtWJoRPABaxiCoRtQEX43jG7iBWOMavX94v
         V6txZOdN1Z6ZxtDgsjKqAmjEkQd/25WyEmQ/5LFsmH4wprJJd5Aj3SA7wqXdUbGh823Q
         jzQGlpZT+BeE7aOWLuVlUXhlwABBDfE/wCxF4MtaskH5egE3hTOW5PjRcA4s+vHKvArv
         c3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224315; x=1790829115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=utux9Bos/pWJu8lCYhGmLIk1AfhqzthyX4rLNn3PWatDTTYmV7/9F9vIjrlI3dFgqR
         FMOnX98OHw8xPqDewVirtOUT2Z8NWbrG6P+74OOXyVI8zG96F7sFfdhrBak2xrbwZbhx
         tqDU/jOdM4tO1uWEKUtn8mayQrlhUP+VHKb4VyOJfu1O+mVOmZ9f9Fb2iAitoWeOfIhH
         91SMvKuPS/ZTRafAGTVOjTgxafAaDPJA4XIKBjWj5rea6I4JrqO1ZhmhHzRmZC4tM/xj
         S6wEhU8Y7pzdMkPk7UrfxhTqUAVimCrfbrSQxS4ccVfrcldDJP9idH+/RA9VqfbPBhK6
         McEg==
X-Forwarded-Encrypted: i=1; AKwUvBzTXuO3tevlpLfd5EgdtyRQ7LraVMH+ryUMp3zqW2KcHVY5uo/xgkL5d6KBvI++ubPtjIyx/YU=@vger.kernel.org
X-Gm-Message-State: AFuF++lVHO3G03xvSrRYXL2IVe20x37DCJTAQbnNjVtFwtO4Whm5coWb
	adDQ7DTe5b7QSjOfexagQkHmWf5iYWbPHm946go5ZdKwfz/CnXSLp/YT
X-Gm-Gg: AYBFou0ocABhMVYKttoP7ZJRwpSE1TFvKN7Cm2qAIBKxY3W5MNuroF/x2YlC8IZ8Xya
	4xI7A8e3W6JMdyre+7CRY039e7EcOIrRDj92G3HOzfgTRlrEZWK8sTgtBYEQi6Yin429wrRtilw
	2CtISXJZR3u//yF3x+o9nJtiYW2tNmQG2RCD1uTX6SdRFUeWqC6TNORxKIoHr4nZB81fl4Nmklc
	FAf/p1AiCIXNpZu0mwZNFwxaZEzrfcqj0e7BAl1fA8lXSbTFoWbeT1L/4wRzYQ5YSmVq4hFkna+
	uL9/PLEwqyt80x5PDqbJPgBbrQg25g6LBHzG0/11mzRXSVJ7aFjcXgMYcxIPUArBWG9f0sXijFJ
	upcgGUTcRM3jrA5F5KvqgNcEooWnPPSYF6v66svb05tU1mVojIeZOkmmXCjc/to/62Wb3hk5VTm
	mvgDpGK2CoTC47jGH/1AdOdqxFTMrOgPWpTmjOZDSSLsv7FZuQDVClXpbIbA5w/OWm/g0nyZzkL
	QdL+jqpU/vjL7loSqtPitQ67KAYq/0JBbb/71nOt/JvYVNFDWKcQu5ch/PvXU7ND/hPPiYrYsF2
	KrEX864VVxMvfAlme4r3NrhZ+Zx+YkDzVQDjdRG0hJBLj5Kv1QkuUK8/YKw=
X-Received: by 2002:a05:6a00:854:b0:857:72ba:ff0e with SMTP id d2e1a72fcca58-87e9947181dmr975987b3a.22.1790224315411;
        Wed, 23 Sep 2026 21:31:55 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1b0b505bsm2219376b3a.8.2026.09.23.21.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:31:55 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 5/6] qnx6: abort mount on superblock magic mismatch when silent is set
Date: Thu, 24 Sep 2026 12:31:51 +0800
Message-ID: <20260924043151.3897375-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921042511.1473629-5-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org> <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-5-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested as described in my reply to 1/6.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
