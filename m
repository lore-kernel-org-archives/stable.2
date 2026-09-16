Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D344C9E0C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602419; cv=none; b=JbmXppk4TDeV/7uUZPN7GNZb2ijWHn602iBQbOLHliI5yslTlvkMcaLU2Q+moDyxyGyz6SWf+UR2KirNsfsjyUwzDWsRPZ4w8qAqbBEQ3ZRhFSR3Pg1/i2VoK+0+0y85qPAH/CX53Eis5lpQ/0FRvD6T5M1TV+XWOMnFOiq0P4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602419; c=relaxed/simple;
	bh=wTlgW8N9K2vFXwRzxcl7LpmXum8Ryq7w5Jahg+Zvf0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uCsf08JmhOVrCLZru7dflo73gBh+gsKZkntPud1yPMqKrYMMjK+m/w0E8+WmB6VNxOdnEW2xTguWOnud9wU97h8PNlJDerB1zi4ZEkOR08HaaaHUw8bysIESbjFZ3mxxavjwwxGuKrUfp5NBPXCChr+nPSN+Yg7uURoq1EG+Dvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=abV9XUKB; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="abV9XUKB"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso142816a91.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789602417; x=1790207217; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wTlgW8N9K2vFXwRzxcl7LpmXum8Ryq7w5Jahg+Zvf0M=;
        b=abV9XUKBTaGItKyIMlVxrZZcUQL8iFgDl8g0iTFLmZUrlS5oeRPy9FfsaZP6T0Lvxx
         RnCtFTs1bxp9nKrGDzeITuYyXWo4nSmnMMIhu+SQ1KeMa1SKjkw2Q9oC2zepejUbWD7F
         3Ogeh4bmsppvU6XUG9vQNMRjxOy2hC7YgeZAfoN86yZkZDtl5qm6N4f2VY6UZKTaiEZE
         l8ZoLbeBKzJOm6e5Y4kntz+mUp1ouurIg56NZ9uhk7icktSn3ZxvHqE9cx1ojw4Pve22
         JycAY1k2A29/9RFZJP3MDb5cX98dzBcC9HXPhb7sjCzrPnpoV2z3rXkELtCUarCZCMwN
         C24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602417; x=1790207217;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wTlgW8N9K2vFXwRzxcl7LpmXum8Ryq7w5Jahg+Zvf0M=;
        b=I4XXhcyeuf6UbaFvfMnMZUYp44qW3wVyrOUhy2Q0gm0UQnDzfiBKrfLeuoSsBbWB6g
         FvjTAje2FQlQ5FjOW/QQblW9eDcI+nei/w7sY6iSSFe1gI6r+GmpJuanWssYvvyg7c5/
         9C314itOPRI6WjfmPHlr0qLYCXhk3s4BHXekZwEZZzrg/uUISbgrvNptbvwK7w3E8dg+
         JT7PRpocvRy6Oe/39bvckz/ZfKdHOpLLo23rT19se9ysw6dNtIRur7tKdjToThYa3Dzf
         WNo9KAThQc4JMeMwCCj55qQEQK7gVmWuNAiIlU25aVcyPKvMosEM7XdR80Wf6OaJXbwF
         1OAg==
X-Gm-Message-State: AFuF++kq/2fmZwyuy30ol47pmsVVQY8/wNRKzDTa1WK4sGVNHBnKhHOJ
	TgToSxCextTE44keg7NVN0Vy8lFnMiarwtB+WUkH5duOa8HObHp1arj2/jfOI/vWiSvQojdO/mo
	wDrc=
X-Gm-Gg: AYBFou0TQsJcsOTDop5vnk0Q/5WAVsMz+jVFmapxrB7XFS1BFN/HUcSjb7ruhZwLIHn
	KJWx1DDblQ9Xy4qo8WesLsp6XCvo/CEUyYtibNblnV35UDOmflJBkFVnqlPKho0XnEu+pw25vwQ
	IgCGGGF3gvhd6qnMiLSE/B5a04P+h6DeW20Yk4NxLqwTWhbzsz7bZNuUzGDqBzfgCnN+gXfbyA3
	V2xc62Jdw9EFGA5h2Jb/4IZGzGAqzugB7ti8OsPEC24mwnu7Yx9YfiS0PNYF+C0CrP1fi0Sszg/
	4Cxcm9qwEb7Gpf/b5PWI7Qp7xpUrP7B9wkle/Bf0+M7QBHKcznajcFqs6lW5LdLrislFRPHr0vb
	ZnXhzZKLUeSim2F4FB9S8nRIkIxDhSOjelj+U4inDdVRyBDwRMC2rk5MrCIvu19hOLCjXVu1IeE
	uHddl8B8KyUVQognwJ+wqsEMg7I++YK3hdxh2Tkyh4MrZwwzQVZBuZkrTq3YSJ+0cAFc1sCU+9W
	r5rBO3E9HnZqRUSEzDGxJzZeVrL1Rm+zmI=
X-Received: by 2002:a17:90b:1845:b0:39d:f259:3363 with SMTP id 98e67ed59e1d1-39e1e491d27mr11260506a91.12.1789602416922;
        Wed, 16 Sep 2026 16:46:56 -0700 (PDT)
Received: from p1 (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d4a48fsm8936453c88.10.2026.09.16.16.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:46:56 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:46:54 -0700
From: Xiang Mei <xmei5@asu.edu>
To: stable@vger.kernel.org
Cc: andi.shyti@kernel.org, dhowells@redhat.com, wsa@kernel.org, 
	rostedt@goodmis.org, khali@linux-fr.org, linux-i2c@vger.kernel.org, 
	bestswngs@gmail.com
Subject: [STABLE REQUEST] i2c: smbus: reject oversized block transfers in the
 common path
Message-ID: <q6ksjepw4p2f3mboxtgavsxkdaee2f4xivqhczsasorea633ur@sk3xiccv7sxz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi stable team,

Could you please consider backporting upstream commit

3051cd060fa496df42954291fa2306ed2eab4ecc
("i2c: smbus: reject oversized block transfers in the common path")

for 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y, and 5.10.y.

It prevents oversized user-controlled SMBus block lengths from reaching
tracepoint memcpy operations and native driver callbacks, fixing
out-of-bounds accesses.

The fix has been in mainline since May 7 but is still absent from the
longterm branches.

The upstream commit applies cleanly to all of these branches.

Thanks,
Xiang
