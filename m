Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B32342538
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678207; cv=none; b=kWzV4AHJKEtK+c2cOO4JLXcBIdJUjkUPVPkcq2myJqZuX9vrxAasLpTf8+OuDBBpyyF/efVQtPeGSR1p4S3I6QOLy3k+ViNfXYjFV87mNBgGgfc9VUx4GQdoPKMj4TYixK3r41bJHx+WTvu/mFNYebIQbvtkd5AgwIYZ2PptI2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678207; c=relaxed/simple;
	bh=99HbLagHbMfIbKQr6E0eGPQiqF2/BQCDaKrbOTg0DuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eh4UEzjSmMMfvMW3qiuAgQVXNGxFYGq4aBE661ysiKiUso00JHK9L8zcabtIrXV6ZWXJv6Pk5YNVn/BAllqWrhw2slZEURJu23vOdTTSSE7WfpF2nOI/su95j+NS6pMr3ufw+QW/mJZP1PhPsVgt1JOquKEDKuRaAQ7Bk13UoI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdKq8FhO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdKq8FhO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caed617615so989915ad.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787678206; x=1788283006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XDC1IHSYbfFXOzEOIwvgdWsLVsv5QpurBF1WjMUS3fM=;
        b=KdKq8FhO822XHPdIZqLo0q8h5HQ4PJsB+xcb/ZdPoSzHASRnOlwp7DboJA3vFLm7Of
         d9PuKtZoc5/vRv4ITp5iZuwTO4msqaIi9HFljtZdpd3IxYLCVB148Pkg65Knm6P5z/3/
         reoa0BEZOB8zIAFXKYtoDzV50CGaNaeHk5hUeoXBgaiX5ReCn9zaUvXJfYy8YsEOGsdN
         Md/hAw1+lUE2bxncAhZutQy7igsZ5Dy2yGHgwKrk6jjQRBXvtrk+xarlG0YbMuRUhq/J
         vlI0Mwx7GjIcxZCtYaj3ve+UZs8ZY8T3r1cayMd5VlIPMEI04cLhxPETuaM1HdBmmvR0
         flaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787678206; x=1788283006;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDC1IHSYbfFXOzEOIwvgdWsLVsv5QpurBF1WjMUS3fM=;
        b=fpCkX1iGEPZ0jrqrKSzJAhuM7EIaojnqAatytKy6gkITiIy5s3BS3JSfKLbGUGriYT
         h4cQC5gssRwdmaRfto9Qf/pFjGfM+IeMLa27z+5A4Psi11dD/GXUl+fbVeIa5Ag+HYaL
         TsE5TkmrnBrc9WWp7vdSvLa0pnPKosYv5Y/fVxWr/f2m3eUvJ8HzlilBFoyuXRsCmBx0
         ZmuxFa2NETuJ1UhmSe6ifNoihXYOU9vcQMwzpL8zHrLhWP4m2ZEg6ogNcsZkMXYGZN9Q
         XrdftSKQNNB/tkAjrUtiF+5KXnWn7Bp0hV0JuVAdCtm4vfCX0VSoWilAur7cu5IdF1o/
         qUFg==
X-Forwarded-Encrypted: i=1; AHgh+RpNxhlcLZ05nNRRNuOTPBakrPNN0vPjkwj44fYCHoZf/XzQQG02I6zwnUSg8djqzPOm7oXC2CA=@vger.kernel.org
X-Gm-Message-State: AFuF++kDefc2jvFO6BZqxnLg2Qlu7vvVMulCdYVMiGkliBnZ8bF8zA1W
	jl+77bZGPQS9ges5uWB4Cqap1hoHCOLEnRYV2O+AvgdQdxEzHp1xSl7s
X-Gm-Gg: AR+sD10ZlNRvv+7q/jNZn4MMoCYGSvvsZR8a9NPkfXQd6K761HPRJ4urWU+Em1FlttR
	L4ECWQhTSgE7Y31EBur2UgWHgoCEThxvwMJX7laos4u8PiG7G7z/mIYJDVBdE6P3TXyWufqoR8N
	ggDKkf91RkdKcjw0lNPwRpRygIRJ/XzUm+yBy0XKcp1OmYhoo7z4dXBEZ0FUJsuRmLky7MefJTV
	OoWVovVca0eEmaHveEzIMeFw28MWdgcMHyhdpxOWQAtbUyj/izZuYqK4xFFLLDJ4dZb6ZGQdSGY
	h6bxobsDvF/df05FXeweeNMduvBSEY/XRrV44nsHAvzcBG0BaoMphxSOwkXgo/ZKrFjIxJOj021
	2SpBnE8nLPucmY2DX7s2fC+ZkUDA89GFxJQBY3f9tKn7YchLDsQ/eeoU/fVZWKrpd0OCW32wpGV
	Mc6CaHML7DV7Mmwz3c/yZcqfO86AHjVuuZTtdb17T5iXzTBDekTX0Dd3s+pmkcHq51DJG1a1URq
	7gvbqGzSMgNFJx9/xhTEi0gtePGtToS
X-Received: by 2002:a17:902:f686:b0:2d0:cc92:f7af with SMTP id d9443c01a7336-2d670c96265mr465462375ad.9.1787678205677;
        Tue, 25 Aug 2026 10:16:45 -0700 (PDT)
Received: from localhost ([2409:40c4:13d:8046:4d30:e4cc:47a7:83a3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d9e5fb1sm572758eec.25.2026.08.25.10.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:16:45 -0700 (PDT)
Date: Tue, 25 Aug 2026 22:46:40 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jjy600901@snu.ac.kr, brauner@kernel.org, eulgyukim@snu.ac.kr, 
	gregkh@linuxfoundation.org, jack@suse.cz, kees@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mjguzik@gmail.com, viro@zeniv.linux.org.uk, 
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: gadget: fix NULL pointer dereference in
 gadget_dev_ioctl()
Message-ID: <ao2-6IlxkmQbf96H@eggarch>
References: <20260824113510.1141236-1-jjy600901@snu.ac.kr>
 <20260825105801.319997-1-lovekeshsolanki00@gmail.com>
 <903f6c28-57f1-4aa2-a111-910fcfbee52b@rowland.harvard.edu>
 <ao2mZdrHdkRTypkU@eggarch>
 <13476f66-13e2-4625-9169-61af0596f6e0@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13476f66-13e2-4625-9169-61af0596f6e0@rowland.harvard.edu>

On Tue, Aug 25, 2026 at 11:40:21AM -0400, Alan Stern wrote:
> But those facts would remain true even if gadgetfs_bind() were to write 
> dev->gadget while holding the lock, wouldn't they?  So the fact that the 
> lock isn't held during the write makes no difference to your patch.
I understand now, I've dropped these irrelavant parts from the commit
message and removed the NULL check in v2. 

Here is the link to v2:
https://lore.kernel.org/all/20260825171343.459630-1-lovekeshsolanki00@gmail.com/T/#u

Regards,
Lovekesh
