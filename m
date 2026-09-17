Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3AD4D487B
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657976; cv=none; b=u6tSRXlUaEpiLEW3xUnNSDJ6gCV/bjh5Li2U+RhJ9TSRIlHE9PTLnSPulM6BJRag7Qu6qdahmUVzUlOoW4+hVlT+0QylPBDEp5rN3eidV/TUwgqC2cCc8j3Ggn03X95SiLBB1y6UwHWMoxUiCPq69zbg3DsFF2FahnyRW5Bhjk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657976; c=relaxed/simple;
	bh=CbunwsL8JbHZjO8IM65+jSsP1jsU9SGK5nn8nXpsnhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIDU+zKgA/FG54AsFTqyHSR/NzZGZt1RUs+BLdalOpV4+nu8/OY40eNIPRZUqwx6NbfSGcW2H4VkdyNQWXsQuNGdGbO6KCuVTFy3vN113Sz0hpmpdjUnJKr7C0aY5MLAdebuzGDv9VPM7wtjw3S8x7gvc9eTmrdKnombwJe/fgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBxp71sC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBxp71sC"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so711668a91.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789657962; x=1790262762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WgO5G/ZcSEJPK2YjMAgrvF67kRqPqqguP0ntcBM5S9w=;
        b=LBxp71sCtwg/qMyTiTQjc2/3DHZHqKjlOFpphNN4oFo9CBqN28bopvWFeCnkuk0Jv+
         0afo460+y04GE9fiHCmQYkb1m2T/CX7HeAYWasghJLUNB4uMOHuK+nw+3FvU2SAERM1l
         39BZdjS1jCQcACWEkGkZQCMBf7owZim6Cq6B7dC5rmoN2qyY0vQTYvNUcBhnuHBQwGwY
         JbnOY1MDu6v4CG8bWOIDWt4kpOETbS6LDEWZxWym3Cde723tIAQKYDyPQl3dCgiRDnya
         fQlhfBJxNJPUvybMM1TXgeusNwiah8BkE/kPr6FYC2VWhM3+cWIxnnk/lTN5MGODB7PP
         UJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789657962; x=1790262762;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WgO5G/ZcSEJPK2YjMAgrvF67kRqPqqguP0ntcBM5S9w=;
        b=ltdMC5YEaB5Pd8pXiFHYSEUOnNFSAbGoCZqf5rWuAWS/O/Z9uH8iVgaHj9A5ifev6w
         UzR+GEhWaLfr4r0tULVQ3zN0AeHfZPforQ5K4rGk+6hBLqA+kcWyeLE830Pr8yArzKwB
         EE5M3il/SbCPcakeppgOeJgY7qwm1qFh3De3d2pup4MhNvpw8kz2Dmf3bVWEB5GOnNW6
         hHAzDdNrHwWnGxsdoDrAhGudLlyYgY1QqPevjD+1u1RPM63SqNiIAx6uaJQYfuQUEYeo
         eLG4TQRnXmcN/q38Danq6AiWck3Asil8DHM/5Mt2a6Dr/LMVF80s8wbm0Kd1gM/FWSe9
         usjw==
X-Forwarded-Encrypted: i=1; AKwUvBwanNu2bduXKGRfDakjvUQi96VKx2pSD9B4YCRBKw7sDVvpIDlcBGLZd/UTJ1ldHyRsy4VIEO4=@vger.kernel.org
X-Gm-Message-State: AFuF++mEc3d+81BeWeH6CiYmyjmWYAoOLVgBxRCpL1Sev8lgjL6ponmx
	Cbe/MnsYBZJxj8m7LpoYwFysGlwTEjtGGijwAquEZVCzdjC/Em2EJp5y
X-Gm-Gg: AYBFou1oF31Ua5IaMc6vGQOo6tuMm5o+ofs1w2jxWR/gm0xFAn5C91hj7S/f8LloJA2
	k81B3VinoGrJYhwkod3ey9HgbuXDKw92oB/PRZlwp5W9ATfpmibFZHzxbJbIUc4uKmsEPeY1SJ8
	woafjnUm0Pq8C73kxHLCgrK4eK56oINLX60XdAXXtmyImcN2IucwtE/32eMOxtO0czRxIJUSbJ6
	m7oA2dgXFI+2FAcl3ZH59ZaN9VE7RLSwRqJWZyFTKHfrTAWl2NM2mInIhLXiGgZT0mPh3IM3GMh
	tB50DGDH/mQkASwhJU2ichNGXQPVZuOJQECjQDXlz/u4pCOdH5xeqjWTjKmJ7lxlbf8mq2vyp8G
	EYTNt4tYkpgKtdbtvYQQ7+v5GbDR9jL6mGLzlWUq8MDDObQ5eXkyL1Duuy9TiP+zShxLai1HW9Z
	b96xHDTqotqsHnfiWGSqLvMo6+yc2K7fdTJrvQoViUagWggIVjpuUqAgzR9H2N8CkUSiC8IgzeD
	Um3nIcXR/ljhlIM0sUfK2bXu/pb+gasyLRDJm+VRNmsuxiL+b4=
X-Received: by 2002:a17:90b:1c84:b0:39e:4c97:ce09 with SMTP id 98e67ed59e1d1-39e4c97cf02mr704994a91.42.1789657961827;
        Thu, 17 Sep 2026 08:12:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:48d2:6852:2cc5:a7b1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d4cbc9sm13251302c88.11.2026.09.17.08.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:12:40 -0700 (PDT)
Date: Thu, 17 Sep 2026 08:12:37 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	samuel@sholland.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: Fix i2c_bus OF node reference leak in ppkb_probe()
Message-ID: <aqwBtYAcIiwSSMmK@google.com>
References: <20260916184721.2093344-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916184721.2093344-1-vulab@iscas.ac.cn>

Hi Wentao,

On Wed, Sep 16, 2026 at 06:47:21PM +0000, Wentao Liang wrote:
> The device node reference returned by of_get_child_by_name() is
> stored as the adapter's of_node but never released, leaking one node
> reference on every probe, successful or not.
> 
> The adapter only borrows the node, so drop the reference once the
> adapter has been added, and also on the error path.

I do not think this is correct fix. The node assigned to the adapter
should stay alive while the adapter is alive.

I think we should convert of_node to fwnode, use device_set_node() to
make sure both fwnode and of_node are pointing to the same thing, and
set up devm_add_action_or_reset() to free the fwnode at the right time. 

Thanks.

-- 
Dmitry
