Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3454257844
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789954969; cv=none; b=rHfQVDfxiKtMD0kI5l4K0JoRDDUfU6OwHpq9cOkVHva5B3BknIl5botwJW/w4+IWMZySzYjxT8enIzMAvA9Ma+GWtEUDPKsEXkP/IZ84s71ydNLVsRH/v+/AQD0b/OPV4N2wLsXoG0Wblhwy0VuaijIzclclC9D6prfed5Zo0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789954969; c=relaxed/simple;
	bh=DWVt9+tgRutO33g/JPjgaS+vnsJ1FuBmWnYngZFepIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5rnQwwK1FQCQmupXH9fVZkEsJgo3ANtaevnMvVcVYLgAbDHftI8wTrW5mYEvDnANthNnGDfH5+5oSBVrH/6R2jLcJyqOQuAyLpfEb6rsii0k9exdUHDWiTMXCdYwMb5KGJz0WQKao6SxHFYy8LPoS0AnWacWsQcnsQ7iO5E+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9+8swQU; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9+8swQU"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39d654f02baso2070685a91.3
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 18:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789954967; x=1790559767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qAwJLJRI1juBA2aagV/5DfGdvOb77xC4nzYYwed9V5Y=;
        b=d9+8swQUIFIpfmYVbnP+toi02K2s1PwaiqiRw78GgUukq0+5ZxKN2ZDr7pg/+eGtkT
         rIxyRyASX+ji7wmrjHGe7UTS6Owzn1x5pH71QLk6z2b2wyCFsKHhp2N60BmXuOEUjpTn
         HCNb4Is6DTlVycscY+idq5nkbPzyxDc/vHbBiL4tzq3QM0dYZ6/e60eQfeF5kyD9voc9
         oUFgN20kw/GDdvZGzdLXCgeszRuIYBX2EhMukBmTLsWfHeEX8qGUYFMaBb5w8NYtJocp
         NZqbi8lGG4ELlsKowFp6g31IohUtUeBrt4bOzEnGLoJ8SxPEJrQkp8YclQJcl+lgPkZ0
         BK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789954967; x=1790559767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qAwJLJRI1juBA2aagV/5DfGdvOb77xC4nzYYwed9V5Y=;
        b=l+1yHtFfOGYVrm+wqsLLwJSdun6AfOw/7c02x+sqoCstN+yi2W2fE6RHDlvhZDAHQf
         MsqzJEeuCgsVrzsyoFI156IPmrB4b/2uu+qz/F3Zl1yBNLz9UyxpNdskvZsPC6Kh/dn1
         d74BGQlp8rHh+PSlp4QjoiRFpuawdDX/xovZxjQG6bswcNS4N+cpHbzEO1SKgQk9iUzn
         Oblej168+FXMh+S1BePDl+WoiuR2RXC6ZzCASM+p0fONuqe+rNAtXBjlA8PvIzFwSVXH
         hnrpK9ANhMpr3Xoo7gQIZI3Em338MHpWKtnKCt9O4tJtII/7iY59WxTd3xceiEXD45qR
         0O5w==
X-Forwarded-Encrypted: i=1; AKwUvBx1G4Ug4HDsrGIZYBplv5XCN+PIdkxTsd0IS2eKVBUgvnWWXyuodOZgloxYSLvTIEDAOj8u6Ok=@vger.kernel.org
X-Gm-Message-State: AFuF++kOpy9qn+r+IphvhqeljS+s1pi5FuHbvsx5iLKXuB+Mf7u/WbTS
	fK5PUelrasI2Er3hlGX2TwUVQ4spvq13LzcrS7sXb1B0i8ikdjraB5ETE6MCT8NG
X-Gm-Gg: AYBFou0a2I39o2whfnFWWABQ8WA+LnnzL+I1K+bXB+U2pID91KJ6do8QSAYTKH7H/is
	/RBb1AKooGL7xNpQ5GpYNZI862o6vW62eJysqSLy2mUZzi9vpHkpZQBGQ9BnzYYde1lH5giP2sk
	ETGOhfD+C/tul786ePN6A++zF5qcC5EhmFPmkkIpYD/RUfVu8KhANTSc7M/rAl6disksRrY4TBq
	g9mD4Ef2VzyfMn0rrpTdF0nCX+1XWjPKqhhnEWhSeQt5S/3sQqxKUXa93VC5aOvW/3D62Aoa/st
	Y2KAq5eKDmX4r9GnFDEnzIPnOfyqDO8RzhyqWJjR4rFLcIud4KxSvuz/1br20zHW2Z2rwtCL1DB
	CZKKgyj3Fto3GKiuk3RwGvFnFIa4l6G9/rf+dYvyf6Kq+g27NUhEcEgUVIl/WElgwaw4GtKL9Rx
	FAMMo16dvldYFDtgc7q4vF2hjV3GsPH+qI4enW/u3D0ujuMmOHRWSaS1XRouOFLQagg1bi74kha
	lNCmaaSgdkYOdoOFp7sAFCSwbBOcKxlWI1JOlmYNJEGLZ2RHayZ/9zoXF9h4ZVGDgzTC4zEsMq0
	8rZkMZmeYQ==
X-Received: by 2002:a17:90b:6c5:b0:3a0:295e:6e58 with SMTP id 98e67ed59e1d1-3a0295e7719mr5642329a91.2.1789954967119;
        Sun, 20 Sep 2026 18:42:47 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cabafbasm11468127a91.10.2026.09.20.18.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 18:42:46 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Hui Peng <benquike@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	michal.pecio@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: core: clear both ep_in and ep_out for non-ep0 control endpoints
Date: Mon, 21 Sep 2026 01:42:44 +0000
Message-ID: <20260921014244.711023-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <fea9a6f7-b6d1-4b20-968d-a306ee4b4e80@rowland.harvard.edu>
References: <20260919223518.3890208-1-benquike@gmail.com> <0bc9c10f-6b6e-429c-a625-d34b12aaf2ef@rowland.harvard.edu> <20260920231702.110963-1-benquike@gmail.com> <fea9a6f7-b6d1-4b20-968d-a306ee4b4e80@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Sep 20, 2026 at 8:21 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>
> You might consider looking through other parts of the code to see if
> they need similar attention.  Historically we haven't been very good
> about supporting control endpoints other than ep0.
>
> Alan Stern

Thank you for the review and Acked-by, Alan.

We will audit the rest of the USB core and host controller paths for
non-ep0 control endpoint handling, and if we find any additional issues,
we will report and submit them in separate patches.

Best regards,
Hui Peng
