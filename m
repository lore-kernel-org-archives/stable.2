Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950FD3469EE
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791779003; cv=none; b=PWGvnVeiTvs/eJ7Y1ZLBXb8qibirp07ulISg+vwZrfDbHoYglsV71zZ7nbmCYDdOStq6090G5oIeKm/HDxguDQteMALzAwKAEyK1PaV87Zz7SXuKMmeNgOksrm4eDfkUZi4zWxX9jjJdeNlUVfb6DzgpHkfacKWhvubZyzmwaAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791779003; c=relaxed/simple;
	bh=lPCfJay/62/aqSCtdYw6Mj/fly70GzFauxJDKqH6fbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ix2cyPvBf7oWboDXhMJvf8Wl1Wi4HAABA4OXGQPZd7QOQ/SCVrXQJxYW/lzxwMPvo/WuX/qvsTqImgwVBxXiSWG76KhztEJS7j4xLKc7VZX1kUTjrJMX8mkV2rlCnI5PGpwByKi188Idl4un0+i0+SBpxUWEAeRHIHMtH4th3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=BlxmtSrm; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="BlxmtSrm"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ccca948203aso421985a12.3
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 21:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791779001; x=1792383801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lPCfJay/62/aqSCtdYw6Mj/fly70GzFauxJDKqH6fbU=;
        b=BlxmtSrmH7cn1/S+LP0TEfR92I7gedMMyGH5KYuJfDihYIG4DIM1JTz2TE+pvR3eRV
         aL8uV0cK69E39t9GjBk/0YGqq0BwdokG0eySP1zKUY3XK8HQdp/dIJBYbVmZFQ+gmKWS
         ZyJ1Ubb6c8M81U/IZc4BodZxUutiQf0STW+2rTumHXrVOp8ZA+jT07muz7yQGd83uoXw
         lafwT1tZFZo9/MXJd9gHoeSvVNS0V+IR9P2inH9y25NTP/AMQMGnVxXYCroobO75rgBI
         zvEa3RGEJZ4ld/ChBOC+n705NdUTui6StuAgbLCS6WuBTB1uTk7YCwy1fsj9NKApxihY
         tE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791779001; x=1792383801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lPCfJay/62/aqSCtdYw6Mj/fly70GzFauxJDKqH6fbU=;
        b=XsIHd/G4246+0sw0+7erqwfjv5ceIlruQp6OsWtb9IRX5zQQX5HwK1/boj5jYXUliE
         iU+Jb9J7kybwzmZ93YgWE3QRTXVTbxm6yzQkmXIK9RFh7v83qxQ3zfARMwLbtwCRWpvC
         5PkGqYuNdanKG7ubGMuA5gTMj9jsVtEigvu2zTWPzT0RJG9PdpMsiJ/4J7vmcleQ3A6N
         OTL5pxK6lLk7cS7X0ZapUNbHkFaNPi4vjToa7qkL25xmjN74KwtuD34oQbIjx+phWNw+
         f1PqhdZXL+urigaG2m4xdvR8LyVfDglMkVs1cPMtGQSRcm1uF9Qq0bQF2PHQnNzcIt7w
         K47g==
X-Forwarded-Encrypted: i=1; AKwUvBz3dJMuDKp32E0JoEd0gi+0OL1J1L1SO3unI9JUldC/KVSLiZdt5XxzRzZMs2lPfZH577mQ98g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQ1Y7jgwVb1I81ZFJXtaweFpQYS8EZFBYF/SrTjcopZyI4MlsB
	1RRRgWqjZ0iq+QBC1R+c231irNW9XGzbTCAciIAtraocvdIJ1oJzLKUQLwVVVxnE2rU=
X-Gm-Gg: AYBFou17Yn1ITAXtjQKbBG+hMgbBpa1taPp1hgC9y3Mz9BFlZQnes1qk3+cVUM2Cj+L
	r/ici8pgzgcUfkgdNyOVZCG/cAaMFINCayhDWs8M73mkvw6qNNUUdZmpmGuIRLzPP+sJdBpyyj5
	DdCcaU5Ry5n48bp7TbVrV+axfQGFiPvOeVmKwN44zlArqZ8FATAQE0cnBQx22lkITe34PUT8skV
	/FCxzjtiSy+1CinEZrzT056h7ym/rkvFxpbOKD/GL5IL55vPNoZWm+UnaCgtnHczG0XgTpEhT2n
	P8Llx/7HaMto0I5jPFlUQbBRsHfYBQsS7DB1NfCO/Lm0byxHEW1rlmK7iLi7u8S1fI69yLohuf8
	JfjwkyM9asvczWLQu5a4cozC+W9qNpGHcl4Kv7F+wFU6wEUUYTDCcDVjWZFOM/+YfjccNdT+RZC
	efVg7h5ZCimsUUFzzYKfK6QCe8GIyUkAkpriV1SnJ9bft8C6Shk/prbzVXdCKfxp4T2phi9MytT
	H0dKlQXCrNW5pxX
X-Received: by 2002:a17:90b:1d4f:b0:3ab:c80:936f with SMTP id 98e67ed59e1d1-3ab3a94ffa7mr6274668a91.16.1791779000936;
        Sun, 11 Oct 2026 21:23:20 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38b9639bsm13989543a91.4.2026.10.11.21.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:23:20 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: Re: [PATCH net v2 0/2] eth: fbnic: validate the Rx completion path
Date: Mon, 12 Oct 2026 13:23:10 +0900
Message-ID: <20261012042310.2167618-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791659860.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791659860.git.yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pw-bot: cr

Superseded by v3: https://lore.kernel.org/netdev/cover.1791775409.git.yhlee@isslab.korea.ac.kr/
