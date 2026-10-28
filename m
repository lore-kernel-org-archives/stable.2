Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205530;
	b=GxtVv5ugtRXcdAyLbh6HWwb88nGyGnT/6QUnQfud1M20AmskQStLUL92OCVwnFgzTtGO
	 k82vyS6fxFccsKajS1GsercXSxNs/fJblmUsi/UNabUeU6lri86Lr8cYFmnUZOMxuYTs7
	 zXjvf8vUoa+zMtXIlWb7szfgM8tB1cB3euk2rAs7MeZIomA4h4OjGsZupQnIVHM+Toycx
	 bl/JZE0WotziFHdFWeB+OdZ+ZU9rvIKBKCcZNvJ2M7OBHvjU1vjM1BEU2BXHKwudWDTur
	 uKnA1imn6UfF5mcAFI2v2NrDUi+k2KE07ZQK2Ats5AuDuu5kTllW1esnhqcAaA79xAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YYg+bgTYV9ji+xIuiu7GqnBDXQOUfklC31rXpMn4A4Y=;
	b=XTYfephWejTOzZGHc8vsFOe0V09cDpUHHHVpywlMLyDndCE4QzXg+jZSvWXXTZkqEFJ/
	 v28aH0AcnGSka6N6xwe6f6J6V9L9MSJTwZhB8DjjCkEW4PHQmp2Ima1pxj17V+bdXyaA5
	 jyuCvG/Gf5ymKHy/rOVh7h4Z/Gnz8zUQdfQh4xI9pDS+1v46XxY9UR2dC4dU+DKNWgUKR
	 VXjIpJ4FUXuMkUxW1ibA0Ic8AClMKhh7WPYrhnDQ7hvy1yeN3F3QRW/9GAYD1f5MEMJTh
	 e6JgDe/goTHvvtQuW18FdHA1BciYht/WCr5nZbEMQTuRTr7C/Fu/KQ8I1lGynItMkUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OPXilkf5;
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE61606B2A3
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EE61606B2A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OPXilkf5
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2eafd4b09b8so169825ad.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793205530; x=1793810330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YYg+bgTYV9ji+xIuiu7GqnBDXQOUfklC31rXpMn4A4Y=;
        b=OPXilkf5W2mSrES/eYAou3I3925xBOmvAKuFXCfpSrnxPLnj4kUMLpI+jLbIXRhBp0
         Tt0n9dCUTuUw8+ZO0sS3kJucb4xltTp5nfTz+RJDWmJduzVdHYqQOd18bWatWyjnNovE
         YlZCPG3PGfuoMn/nqpAYtqGfP03M+3OSETEe8SNAH7VY91zPeU6BdgPCaw7u3EZmO7vY
         RUkAZYxo8g0xeRYpPdlRVmnVn5D7sjsWuZkGbk9BiCb0oSCZaraD8+H9mZKKzy9GcRFI
         A2ug5sAisBx6jr7IUqNsAwR0TnA6JRYhH+UizrU2Unehh9dbkTbDZdHmIia2jek02aWn
         t5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205530; x=1793810330;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YYg+bgTYV9ji+xIuiu7GqnBDXQOUfklC31rXpMn4A4Y=;
        b=bmma8lJ4L9pHFAhtPlcFyfPXlaoYp7ZkN2Af+xtqgnZQ+fVq/6Uaef+xyDkvZW+YqO
         7ryKTOshW5HvJWhuZLql4l/Z4j0Bpz6IR9lP4v72p3vv8g9/axjnYokpOSN5UOm9l+cQ
         WetbFwxymP6u+bfbwOIT3hWyvGI9vnv0zOuYUPHiYway0EMGyljEfo2TE4LZzi3atYRq
         qg4ti/1ksEaxFT/UDCaY9EWR2TVAkH0be/2/C9J4975Sar9HGwO/Qnh8YMYxgXL2CLoX
         m15aNaB8xiRP0BApGiYRoChYq88WR/EZZ0AFsHgshb0A27jHPgen52ACCn9l1iRyAtYf
         gpiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzesBW8ecXsUASXpYaloPGOQy7QW618XdEF0LC7ZvCLaliEhUmg+G/LJ4Pu/J857l+WRONnwrQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLosBLt9uKNKpievz0Cnb8vXoRt8mGsjiZrQ+p0PiuxZR70GR7o
	+gaHsKq/RJ6Gb1s6AmWlu0Ouhw3c1T/zJyDKsIvqI0M9ioSB518jXDpf
X-Gm-Gg: AYBFou0S24er4NOZOnwY4L6qvOySt+x+1zOB38zYrZxo6kaFcoqR2IsW1IqPmgcMWl4
	69YhRiJtbaq2DxMkmqEXU3nB659NV8ZmZWv7yMduNOA7NmUDjw3cssV/Zh5Jgd5FgrHY5N5J6kZ
	4eNkdwqHQpjaTdm7zVn6rODbf/uYCmk8ENsdwRP7lMSKYTvasGLSaTsl8KzgIyC927uTqdBIT1d
	J25fHKwo0NMWsPaldEgkqu34ZpU4DLYU55O81f8ywBUOe6FUHcK89e9GBEcF9yxLm24soB6MSsn
	9VBqrTeGA9Su8HvBp8snQFxFR8rQjpuEuMA98DM6+GgWk6jU42NzJbFhMIci42K+gKJR2WF2TeT
	3F1YdcMMbsUXfa2pNYeJVE21+ag2+f7YGSInuAh00B8eeYIyeCzF07T2evIlug+BXGzXOcmSrQi
	E3K1IAcmJ6xq8q5acjadZ2mIBKp9ouIvz+75ewuiHtHONkFxKsMZVA4BHRvIWPV6rV+NbQlX7kY
	WBmFclUrVAdSuWHE1SLs2zmATjCI3XwIOL32m0DC6mk6zN5DqiWSNrR8cb5U0MduWBjGHQFWlFB
	cjBJnhAo5tHX3TjLFq50Q9nwWRpNCTE522xPmJhIZz1R8lj6/7Ji
X-Received: by 2002:a05:6a21:496:b0:3e1:9071:acb2 with SMTP id adf61e73a8af0-3e913a7ca80mr44385637.33.1793205529784;
        Wed, 28 Oct 2026 09:38:49 -0700 (PDT)
Received: from 192.168.1.7 ([2409:8a1e:2330:4ef0:1490:f0fa:6df7:f234])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cc9b25a3sm4395321a12.2.2026.10.28.09.38.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 09:38:49 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Thu, 29 Oct 2026 00:38:39 +0800
Message-Id: <20261028163839.82573-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <auH2iJ9oXEQRVG26@boxer>
References: <20261028025026.11401-1-testwrzwrz@gmail.com> <20261028025026.11401-3-testwrzwrz@gmail.com> <auH2iJ9oXEQRVG26@boxer>
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

Following up: I extended the selftest to run every descriptor count from
1 through MAX_SKB_FRAGS + 1, not just 1, 2, and the maximum. This also
covers uneven fragment splits. All cases pass.

Thanks,
Rongzheng
