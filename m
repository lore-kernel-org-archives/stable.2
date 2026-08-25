Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C5F3A4F50
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 05:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635257; cv=none; b=jibmCpoHZ76gwNeVo61p2dkXsevaKSMrqfE/sulZZJHomaWODaZrg4D3LCwcI1jj4u4lxEmhnqCnKdtlStKbLY6Yg1y2++QhCBSWWGIElVXQzGa1yaV9W1AsU2ODYCorF1unn5nipzwB5XO9vHLvERuZ15E0iSaPfvyd/a431ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635257; c=relaxed/simple;
	bh=c/zSn87gCTjzjIcjnVDD3vC4OrOaxiOrWIvV+BS/duw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7C0xnrCePZS+DJoOr2jhGpIbq9yb4Fv/Qf+8ul32LdSZ0GzhHCton1afiTOlKxpUXOsH3lss2zGRGGS8yqAEamStCvEgpR9MLMwVSDJAGUeAyBo0bWRcgTphUzWy8SZ8qzQ77x++hoTLUZ8blWxwDTV5urTU7uMocxuuhK9wKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoEf9y1g; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoEf9y1g"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e58034d05so3877274a91.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 22:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787635255; x=1788240055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c/zSn87gCTjzjIcjnVDD3vC4OrOaxiOrWIvV+BS/duw=;
        b=VoEf9y1gP7SYXJGzmJW+aPGJ/eFT4Nlkhg7RFrY81/uo6KQI83tcin2Rl9/B3Bb3vz
         O9JESsHMOo9afrcc0oXv0q+9OEN8InpnOGCoPhNAI/mathf6a80VXpP0RKRapoGjdXPO
         It0OlRYExxdubEa1B02k9JK85e9gZGDBwQ3V4b/kg74FOjptX59xua/c5AxY0CuJPTqd
         M/JnNzTScf9EBYV0yBqw7F0P3uMykjSXc/CloTO91Uf2Fnf74/MB98y/NjvsW11BoPDd
         ukODbYxZwni4YHN7KHfatvxOZIisNQUNP/X6ytxfLa/0JxCbl9vSDRsT6xVh5ea3R4wi
         KaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787635255; x=1788240055;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c/zSn87gCTjzjIcjnVDD3vC4OrOaxiOrWIvV+BS/duw=;
        b=SyvM4bsrYGxExCKbcFmCgyhRD4XdJAM+c/fVWhcd8WnLY8M7pLSobngkHatENc3AEd
         ETzFXp04D6V1YBrhTygLLq/HHdX7MUespGoL/B80byCr5teIotzAkHOZWvhxr6Mj9xP3
         lmvcpGREGMwqPSVcYviPKHz8flDW8quvk92v8JTKvIWnehtLSooWfiYAmxXxrFfS2RCP
         o+ajsWt1lB+fI7jED7BWMc7n0f63JP0eLyt51n0AMEhMfzZIMWQwwQig1mDUwfkyNrNa
         uhaSUrFC88hPSpWCD04MD+2WjN063peVaVvRt7+Vw/sTg3G7FU8SI51nG1LOQdSCG9jO
         fGAQ==
X-Forwarded-Encrypted: i=1; AHgh+Romd6RGZphX1yGv54UMf1jrjrGqJhvbL5MVKHTX5ELEfRyTAAkXCInsxcbjyi5nqoQJH4GQP2c=@vger.kernel.org
X-Gm-Message-State: AFuF++n/6PZoaGwVus0OBhPA2AfZbpkmxZDS+oxvT3kGaWIe7+o+wbLA
	TSlURsAfCsNKa1sO1Z7OizV9+2x0akphfXZKu8ycozbOpjvX4bofbBGO
X-Gm-Gg: AR+sD10JCNE4AMCPdaWkwb7w5RmSgIuvMQ8Krd9VTDpii6if2H6Cas3Ia8y2OSS2Ik2
	XoiYLSTyFIZx4nFJ4SrtH/6ZUfj6vXJh7culUzFn+0HNGer/jH8Uqu4O/gzg03EOIkKC1WDYP+w
	HVEYYj1kgLo7Utk4sC98u9lLZbLNUNrVUqFuzzW0TpKx1AgCoV8XDb4XHP9REuWd5DWSSz+W6/K
	Fv/SuW3m0ColKZyTYKhXLFcQfPOVsI5E8R65vFv/zfUP7epj532SRIVqFuz1A3K0xwb+peWPbMU
	GYF/8e3F0oBHI4EKl3/jO6pHjLD807t0qnIbET3Eh3nbBpRg6uuiHe25EwuiDj9en8Qjj9DhRNx
	yKCrvKiAqW5fFM6QHy4CHtvPn3cGzwTGsP7cOZUVt/PQ5MTy2c/EFGaqQp6b+gElpEwQZmrV7aR
	pYqBG4f18jLQj4SHbwFDoGWHWsI1pxuMreWARICEwTNybomhAOb5KRitjJFJFlWeY=
X-Received: by 2002:a17:90b:4a81:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-395c33ec558mr54049572a91.7.1787635254932;
        Mon, 24 Aug 2026 22:20:54 -0700 (PDT)
Received: from Default ([2409:40f4:1006:fae2:f5ac:f8df:7687:b6f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d36f9sm48047175eec.16.2026.08.24.22.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 22:20:54 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: heikki.krogerus@linux.intel.com,
	jeffinphilip14@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mika.westerberg@linux.intel.com,
	stable@vger.kernel.org,
	syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] general protection fault in wcove_typec_probe
Date: Tue, 25 Aug 2026 10:50:29 +0530
Message-ID: <20260825052038.23669-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082540-tarantula-gigantic-b786@gregkh>
References: <2026082540-tarantula-gigantic-b786@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

On Tue, Aug 25, 2026, 10:42 AM, Greg KH wrote:
>Please do not think that this is a valid path for syzbot to be
>fuzzing...

Understood

Thanks,
Jeffin.

