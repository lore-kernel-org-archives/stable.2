Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652D472F64
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706414; cv=none; b=qOEnMv6XosWFR6aHTrJ2AyegNMR9Nras2uiKs3rVzCM+gmJVyR2fLedU95ZpytP6vESrDRTZ6TdR+yn2gO+pVIZ0dZHwzKUIsL/ES6OkcwlmMf38Uy1650gaRad7yXW3J6xKgbkx7ZWsL1WJd794PQfjAdSUO43M8t9BDlPiSTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706414; c=relaxed/simple;
	bh=g9ZuArkly/LA+zIEj9CLdctE+mRUBOwoLscEC0kADK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivHbU2+I8LxTJs4B6m5OausMhCuo6lMrhQi6nX6CHOLwHFp1bwZ9onYfvFym9uAJ79rkqAaZWuWLWVtpyskaK+pBW86e8QVtKkS48/jRyj0SQzwXIdabt5TDYzfLdNd+WGVKDUQR53I51hPblwFDnpuyqwQdysc3txekemPkRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFtnejR3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFtnejR3"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c998fd549a8so8073058a12.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784706412; x=1785311212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g9ZuArkly/LA+zIEj9CLdctE+mRUBOwoLscEC0kADK0=;
        b=JFtnejR31LwqmjNc3dx+wqmJ4fjy5njEYD0C5MMvd2iUPD7xgWZ11aaBJJ/rKAMOqH
         cKGcF3jB+o94axaoANz2cbyCms8xSZmBBKcE+zOmiCcavI+TuxP99nMIJxF0+/hWPkCS
         3sKVy5fy2NMVzj7wpCPv5MkdG5CHQ4ytrGAv8nLY+bxC2EMaT+iICvtPWqcp0ySq6AbO
         n1tbs10eW362maEQdaSYiBVsbNQDheeTGEU81omYmeV5XaEusHTfqpPOlyC1tqhtFsLB
         wIL3RGCj0XBXYSdyJ5EFrKOqiIAwc/n2znRDDvdlsGX9/eh0iysWRstBsoxsAbRMhMif
         SYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784706412; x=1785311212;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9ZuArkly/LA+zIEj9CLdctE+mRUBOwoLscEC0kADK0=;
        b=jrzpaw9j/LMKjF9/BorhC/r7T/o3d7BAfPvcR3ZerfM4f3cR7VwzJxvVjFqPGuFwHf
         QB35haimBDUZOiTaIAAitw952bPLkF0Fuvi+Vk20biuaqzd3+9/hT+UgG/BIhxiOoe8G
         jcWDQ05RE48d6RvHAKrS3+K4tOhO3GXecNLYafDglMcC6cfmwyspeKXuDeIWeSf/4QmA
         IoFm/+5weWDXpxADKWKTQwGle+wfUIDl1L+toOx5HxNfHduBs6obrfFNYoAnqNOeuam3
         QxGO2FauJB5ZxtDYUPsrSQN0wIyMi4RfaNCQlAH2CqaAcDZwgLGYvYIw5kHM5mlNFtzF
         0n+A==
X-Forwarded-Encrypted: i=1; AHgh+RqFMmPJcZNju/D5xQElpmjtSG+/+EChLb46S4t9v7Rwf0/+aY6hS5qNY0hx+jmtgt4YVCPYw1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxw480gjxYFNNmO2N7DVmEgrLtGX+cK5mHW0X+KCs7wvo21lPO
	wh0vxiHUAc8y7a7ub21l1poXWbqOA+cDuzfqGuQn64QtGZJeH07K5XYb
X-Gm-Gg: AR+sD10al/DyOuMGL1ACtYHH87s+G8o/YFUBVB0Zt7WpeyARVTCfMX6bWRVKnYmlG0z
	nQ9mEhj5f9C3zcFFInalALuMhvGB7+LsXxQUAjqWaOumZaPdmViJ2B2vE8ayG32uWBThdSuFZQ5
	ERGXFistT+UqHYTkOh/vXOmPbrE7t5KxQPZpCCoWKH+k2qYchSS1vMbQXpo3rfanrE4vYkYL5bi
	GjNFvZBs8FAKZ9zy65sO/xEf2RfqZu6McgetuQyOpO2SP7evw3fEz2MiW3Ghdcmcq1CdA4vhlbT
	BrxYaZXOOaZCwH2sXKaocgxl3eC2yBdfsv/e7fbzaHPteQvQnLzon52XEgB14krJfKqXcPHFyaD
	idIrsngKCvqszZQExzyu1pYvM6xneBUyQFQLDwVrMHzq43NlOMYWxKFYNJ6ZN8VDW1GAyxICwf/
	q9aEGka7CGyBhGSsPt5NW6UT70sXRZkHt2vsn6IUyi84arkDIwuAG+/dpEHWmgMau2eWrAFTlGC
	anBbzLzgA==
X-Received: by 2002:a05:6a20:431e:b0:3c4:2b8b:e17d with SMTP id adf61e73a8af0-3c42b8be321mr2795044637.58.1784706412251;
        Wed, 22 Jul 2026 00:46:52 -0700 (PDT)
Received: from archlinux ([2405:201:1b:20ef:3bd0:b711:249b:6c29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df0686fsm6551316eec.14.2026.07.22.00.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:46:51 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:16:47 +0530
From: Krishna Chomal <krishna.chomal108@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ilpo.jarvinen@linux.intel.com, sivasli-ahmet@gmx.de, 
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] platform/x86: hp-wmi: Add support for
 Omen 16-ap0xxx (8E35)" failed to apply to 6.18-stable tree
Message-ID: <amB1Uk4njddRUv0c@archlinux>
References: <2026072000-unfitted-elope-1652@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <2026072000-unfitted-elope-1652@gregkh>

On Mon, Jul 20, 2026 at 05:29:00PM +0200, gregkh@linuxfoundation.org wrote:
>
>The patch below does not apply to the 6.18-stable tree.
>If someone wants it applied there, or to any other stable or longterm
>tree, then please email the backport, including the original git commit
>id to <stable@vger.kernel.org>.

Please drop this patch for 6.18.y. These board quirks depend on driver
refactoring in mainline commit eeeb4c9874bb7, so backporting them to 6.18
isn't feasible without porting significant driver changes. 7.1+ is fine.
