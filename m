Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2574326927
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 04:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224313; cv=none; b=UwyC8cwq43kPZ6LzpWRhdLBhr1ppVTRZMR9paW1AHoKKHAjqfUvmXiruaQPetmoq9ZCXJxLgBa/FHimL6VNh5BYu1Gs7GtnJMlQhqz9VHlUFpnmnK3EMmGVixhAmVNMwmbfKhZNNlyrCB/H8wbnc8PUNAsK8nQSgkJY1C9gmnBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224313; c=relaxed/simple;
	bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C51+KH9gQ7StCi1aHWD1MW/7YfuOE9oKyi0DZxSs3R9hFs5QrhKQsGJgWSLsRaPJnqEVOVCFwwxUiV+KkV7rUQXeD2eNfdRCbr1iuUnAcoNuqc+zLD59/3Nef7It0u0GVcZu0gv1ViBiIqg00dc51VQPuid2sdhiKH8owJ3cpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGMKEW1o; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGMKEW1o"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8686f46e4adso1109894b3a.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 21:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224311; x=1790829111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=KGMKEW1orZvBY4yw+WOCDo7fvXIDazj7Xjhu/dAb4swk0MDdpUQKXAX1ZdP+epMayb
         mj5dle/aTGZ4fCpry0AZXNp4Bk1R3Xs/7tyuzkii672jvgnjYorfkDxrgeFZvUqcvIdD
         zaUauQdwUYbLpJ9CL64Dsg8UDo1Xp7m3pbjuqRfTZyYrZB5mFDKzXSssB0QPFEnXEyNz
         iHgf+TXoOdMTKVd8yp2d/gtDTXzriUBuxOzhrHHRRamIgT6q9NJ9YUe/Gz5QDDshmNWV
         0dzxI6KsWpCqyU746qAJobnmOwagHDOKX57krgsnZhY7ODOJGjFyksDoWtVCjeEqL5km
         d+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224311; x=1790829111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=F3Ye97MyjK5cl4w4Pd41rMVt+ZaO1RU7qlVedrKl/khX2IvFSEs/2KSnbrUjSOToUj
         Hucb3UEnazvJNF7+cRfJnN06BhX8S9oceSwKe4i7IdG0abvfWocuwzRYsLfmO77dbMig
         yOkX1dwzFB/u2V5wAxG4mKuhloG9AtLN8stgPPUp6iPAI4Ygx6U2/Zx1D5+uLC7o2By4
         eP/q1Ro5bxCaDpYYt6g39N6FqUWlilA1zOVbbddH7xJOtSVqhct0nTZExdrIHpsViKrc
         2GVoPxhaD3Fxyrbp9K1Ljdw4B/uuNbyXesZk6+6ud8wXdI/VJ3eqTZcbTYP7rB5m1ypS
         6ZKg==
X-Forwarded-Encrypted: i=1; AKwUvBxJTSLiNQhlbUhYmMQ8BSCoriKkP60JsPQ2LDuTlVIRHKqkyFafQjqvVpT3lvOknNMMeAFkXIg=@vger.kernel.org
X-Gm-Message-State: AFuF++n9LXNKmAiT7sRMdI8CLGHJMzbqRIuc34iY74mxyqW9dFU4AIHT
	BeJdRT+Y8UFF64+Pp9LUuo7QAf6iBNpI0fVKNW/hPEciakGe2iSl1vjW
X-Gm-Gg: AYBFou0zXNnaj4g+HZNp4jmJr7RHXVF4H1+GNaBu+mcMqyFuEB6q117Yt5xuU0/Wlhs
	jHFflPCKwnmGvvi3aOooykN+h4brLl3n0R2AixJhMyByhBYubRZYoIn5VnguB0uywpnZabqVb4R
	0wYqriHm1ekV8NZz1u28PdbvknXxolB230rHDyiPkMVUNDhCOgWVC9DbSM3vmQ+uPZA9NSy54lK
	UNxQDwJKGdDXFwDoF54zb2YbSQU06B8wt+sCe41yiZQl7pJayxBHmx/qqNzW5DyWCUSV9xazxGB
	127QWDvEYH7+Vc/KCjv0cQ7pf+mUSVHXvEDzugb3AU5gg6o9B1ekIfB0F8aGe604EXyfpYGhtrA
	IgsQTdvShg2qM9iuyTRkium4jgUESM9UGSf6hwHuP/P1fkoGRMGDSwTHRF5jve8s6TCAqBTQ/kD
	61Q2cN0d0hsVqAmmnRMM5jaXT9P81h999smC7cnLxn0heLtkGeAZo+sm6zP5d9O/kgc1dqVbkP+
	2akvKTagZSZVmJUf+NEu9KGTfrG/VyouWQZbk2win1BAxdhnZnDaY9Y8sJqnJDA8PpnrREBhhjq
	80twLN6jus3evU0B6g6CYUzhrWkAQcveVWeXx8PMP7scqqX664pSk225lwrnPVC88joqfA==
X-Received: by 2002:a05:6a00:398b:b0:878:34d7:6a2c with SMTP id d2e1a72fcca58-87e9c069ab3mr997440b3a.46.1790224311140;
        Wed, 23 Sep 2026 21:31:51 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5c12besm2165286b3a.29.2026.09.23.21.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:31:50 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/6] qnx6: release sb_buf on mmi_fs error path in qnx6_fill_super()
Date: Thu, 24 Sep 2026 12:31:47 +0800
Message-ID: <20260924043147.3896456-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921042511.1473629-4-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org> <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-4-benquike@gmail.com>
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
