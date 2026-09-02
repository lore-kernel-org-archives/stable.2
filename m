Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370994A3D28
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360565; cv=none; b=RkotStj2cSy2N7z58d8sunvzQxoSvu6wQW2/ilQoOrsXBrZWVnyrEHQWlGK+at9J+yUKv86tI8HojgU+DrRBxRIHAStR330mVVQH2YVOq9HDYQYq7OzW31Ew/uEN3U1TzRmsIwjKtjfKIDS0cDal1v8FlxdP91SthfZfli/g55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360565; c=relaxed/simple;
	bh=o3ilph5W2vSVFluZzVmnRj0Zf/2T3yXy4uJ/eJj36UI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JQcPUiCY22I/n1oFvyqhCl2ldxkZ+wEeCl9RqgbovU47iAbiYiGNuI2NoNCBDuYuJVYyJ4oaVYRfiGNYH8u/JKgvOGdhE9jk2Z1zHRcCMTzFsgnqTDHU7hN3NuZ0Pr2mkFdeJxKWW2LleC0hxvZBJOsCJeEcdkoxETNGMmglwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZkFCGWQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nck7uxVb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZkFCGWQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nck7uxVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788360561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqFrysN/+2cVNmsG8C/cGiUNyDrof3Ao3d+7KzBs1dg=;
	b=gZkFCGWQIdsI2NdQlpsRzyW0oToZIn+9rCuwGd6+Zo8J0boC8lWR6tYdBuZ5GXNtWRQS+/
	yhkw6wuwyU9LD9DU9rxS5Rvs1wNeH92nZlWYbSRpBEaakbuCB7+MA6clOJAXN/lKI6dEN6
	mFeBMqUPAKt35/HTo4S1Mbh35QXGQJY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-t3MhmQ1aNoaOLJAJPzxZpA-1; Wed, 02 Sep 2026 10:49:19 -0400
X-MC-Unique: t3MhmQ1aNoaOLJAJPzxZpA-1
X-Mimecast-MFC-AGG-ID: t3MhmQ1aNoaOLJAJPzxZpA_1788360558
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90e853561c5so14266786d6.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788360558; x=1788965358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bqFrysN/+2cVNmsG8C/cGiUNyDrof3Ao3d+7KzBs1dg=;
        b=Nck7uxVbOT95Jisqv+FV1qhJppIYU8HSPkF0c+Orl7YSQ6B4HthA7OgZdudlVZQrm4
         iD02DQ9ApI0tuTDAruumtpohojgVu970JHvdZbtwhWwpIqGJWFlnSZkSb5sc8nnN/epH
         wK5skCoXn78Hak25qB3wDsu0cFw47nB9aj8aaBQGfXIluarxXHvQ3wXXE9Gr4rL4TZOU
         Hk3JKWdjmVE7VgheHcS2gGGyXVywQ8SyXJ1yIE0K8hW8c84OgEAMddRb8/MYbWlVE4jH
         tbrG+xEsjU31QZhbmntKBmAWgK+kwKGglvr5B0iHbFxEIa1ay5750wE7DKi+ADIT5nM5
         l64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788360558; x=1788965358;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqFrysN/+2cVNmsG8C/cGiUNyDrof3Ao3d+7KzBs1dg=;
        b=OjuWnrF/i3d4XnGUI3q06EdP8orBbvXqRid+LiCMklK6YqZsJvYZeM1Pm4ct7WfidS
         URQSZWaMrcUfRfY270IJsIMKOnv6Cc6+rKvCrWEw58pEfrnjAnZItEEMDLXbJMs1zk8U
         EslmyxhhlR2LnZ47GBNNRYkHix4dpiQg8GAUNO5C/NgsjlcAwaq5MY7OjrL0aQa0pmw4
         rsBrDj1OCHQElUWvIR1bFYSvmUn9bZrJ+7tSRxha75OlprnKDMs0D2aF3WC+RL7sBZcV
         W1E9SsCEpLPRaPJNDN/4mjsHwoY8knY6iFOaURgUshJS7EIiYwFJKiXY9QmhWmdKPuDP
         U2UQ==
X-Forwarded-Encrypted: i=1; AKwUvBy78gDWQlLEjOm1KPdG2MnMLclVDGRIxgeOHtYdNcvLXQD6YxGd7WTaBGw4V9g4KsUVBAHFfhM=@vger.kernel.org
X-Gm-Message-State: AFuF++lSnrdz7VsViySGbduBsPXZAVAWu3V+aktLNkj6sEBFnLOq1GOS
	d20qDlhW+zeyT0FUlU9f9eSPMrUXlaG4RGzZCNtGwKcYYRJfoPGNjEIu2ZBD0iuTs/S5X5FYJ/Q
	IgwR6L3nOm3Ajm7qi6FZ81DVSuSSYPEFu24/OhGiME7S8gYKqmwRrnpnOY23rPJj9fQrpSAn6br
	YyVHnor7oc1iBd8L7H6Ws4Cf2whIB/ZfBnAVX+0z2M
X-Gm-Gg: AYBFou2fNx3S4OmETtqtovW5OAZ8vLnaXM1cgo1csaB9ZYntJl18LfZp0Ojs0CRqznz
	wE95XG6yIG/E5xyYrR/rmEHW1KJKTxCU7iEU9ELnz5cO8tJLqnlAi+5dJIzmsyy2at3l8LVFTUT
	JlCoNVwgh/sOxN4hs1M878/O6XPQ1B7W32Aq2w3Sh1gFEd87OYGf9S+fXpmSxnXgC7WUoOsmCgq
	+Q745to83vQEdvKvSfWydjOt7/tUxm0tRDPVuPoefvi5V28SWU9RPedKB++cCbe8LyrOqDd7M7f
	oIa69z5CCdOtQhipPhBLiGXtziWlfQmHrJqeloLWFvgYoWMRQ4TGzNeRVl9AnScwtd4NDSAoTTz
	ajDxEmC03/HfcTvmhbeaaoluXVKFbq+ORF866Y6I=
X-Received: by 2002:a05:6214:2b0a:b0:90e:8dcc:4e5 with SMTP id 6a1803df08f44-90ebafb8fefmr72182366d6.28.1788360558270;
        Wed, 02 Sep 2026 07:49:18 -0700 (PDT)
X-Received: by 2002:a05:6214:2b0a:b0:90e:8dcc:4e5 with SMTP id 6a1803df08f44-90ebafb8fefmr72181126d6.28.1788360557564;
        Wed, 02 Sep 2026 07:49:17 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eec8482sm19647986d6.31.2026.09.02.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:49:16 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: Daniel Palmer <daniel@thingy.jp>, 
 Romain Perier <romain.perier@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, hanzhijian <hanzhijian1991@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260824142800.3497263-1-hanzhijian1991@gmail.com>
References: <20260824142800.3497263-1-hanzhijian1991@gmail.com>
Subject: Re: [PATCH v2] clk: mstar: msc313-mpll: fix off-by-one in clock
 array allocation
Message-Id: <178836054100.2017040.16035095251394555993.b4-ty@b4>
Date: Wed, 02 Sep 2026 10:49:01 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=332; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=idLPkDsA8mhI1Ih+j5hSWIEMKho7R3PzR+kQbEfB5mg=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLJmmKdNeOt2NXwvq8a0uXzTGK91flEzf1zEn9/tJ7lxd
 uxx2eagjlIWBjEuBlkxRZYluUYFEamrbO/d0WSBmcPKBDKEgYtTACaS94jhn36ndiwDS89kU/kU
 4xW5Rw2qK/X+qds+mnL19/FU5s3S6xgZGm8m+nMnrD7x/5+EmK2SqqDHZFsBaaMLxtKucwwemrY
 xAQA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087


On Mon, 24 Aug 2026 22:28:00 +0800, hanzhijian wrote:
> clk: mstar: msc313-mpll: fix off-by-one in clock array allocation

Applied, thanks!

[1/1] clk: mstar: msc313-mpll: fix off-by-one in clock array allocation
      commit: 712b75152c00a8ab0c56dbfe34caf88e3870ddde

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

