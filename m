Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CA741169B
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243389; cv=none; b=peGM1dHoaEO5ypUcjUoApSSWiOWT88/7+fjMf/4Q7c6bFZTc1sBGeG4q5Xtd51IJdwEfauBThb/yWt+aQFanHp5KuRyrukZz2qPcUrmvGx1OrPJtlLH4yYJnhP/mPcd4rLBRC2OB1wf26r+YB7mg6Torg8R3O5ap+0i/BSAT72w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243389; c=relaxed/simple;
	bh=6AxHVVl+gZTn8j7aNuoJz+d9M/a0mR4Yz8N6BMkLiwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y9FZ5NkHFjW7bSklis3Dxdv8obiJX1rhmJc7vFoLCw8WE8OKh4XH7ooUxdDNJpKMfa6RE7NWu5cUBpjP4osKRhvJfXDxzjJtA5J4hSyk11dWQVzEOZujCu27GIt8XGIxy6uGaHSG5EV0cC82oE2BFM0FLkme2a//WLpb5NEnVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so1298518f8f.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 02:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243358; x=1790848158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wBClDNoiMcfukXqTKxUO0O44/6vZOeXszispr41Gs0A=;
        b=0K9f4LU2Sk864LjRUWeWmqNCeXf3fbQ7yVnhNO63yysylRJllsEZPAYb+8SqiXnUpT
         gVCd1jzGQ6dtwWSSebBvOhyJkSJY5WqWuE0VQhfPba7+mCxpizGVGx7s3fcGQlyz8HRF
         vCqbHQP083F+xFMFsV9TQC8EznzDErO6/hy1lybMWuA4XAaw4MKSyUb5qX9+k0hvpg7i
         fYlJdP431IT/xlIfFVAJrzipUzEm22BXT2vdNFTRXO9cRvGCsiR+pFbxMbM9tRI/nvTd
         bvsjCz92mOn9pznxm8mTpkwH4P7fG7NCOjs4q3oWgtKZ+2IX4NVX3qdDdpheValv/VXh
         hD8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzk49AO1yatAZlYBLvQzy887FxMIhsQOSt3I1Aw1ifTkvRWVK5HNWIsG1Dd0TJnU/wdgFpXEJ4=@vger.kernel.org
X-Gm-Message-State: AFuF++kb6/0ZJCRd6nEq5fCqde65vrde7Pcg5JvwPXomTIVEsE2GxxiB
	jkW+mzV+v4MyZgnSvUy/9d10Eht2j0968+MsBgXfbSpOLR3eAqhFvAfo
X-Gm-Gg: AYBFou3QoNk1cELwyp2axNnlA8yW2JaoE+qR5+BzZLNIsstBRLrjHAyOgN5Hlc6q0HV
	PNXjKKSX26bcE/coOh0DxOdcCXjD03wp5sh8zOZpAH82CoviiSPpIqVuvHGb9Q84gPs9uw6k909
	uk/rs1cLzt3es2jAkEFzyzjZhgjpBPCslGwS4pGPnZnthTycVzKJ+MNsQsf9bHj9TsxJb2l32k2
	vZAyWl/4NUPQFqH0ZukeYoJgPhLQGN23Z5P44G7AibfJTFdj+MSz1BNgQsFgrZSO4qv72dod/3Q
	7vczg43L6xKcp5zI+kKlpo14b8FmiS62Hee1/vPSZR3ksV0P0wLwYnnV2uhKL3acJW/jHXfOCs1
	bWKohGdJ+aul9MYDA2UtTicyWQo61uWU8Ryf3LR6j6GgiTfDzaYxrdRUuaciSU+4fb8V59Q/zVA
	zGBw4RvwjbntnuF6UaGNRMWWqGNV/HexfWfCEf6obyOVaVnlgop4qzEsOX2u0=
X-Received: by 2002:a05:6000:2584:b0:487:8ec:1fc with SMTP id ffacd0b85a97d-4887170d3f8mr3448462f8f.12.1790243358351;
        Thu, 24 Sep 2026 02:49:18 -0700 (PDT)
Received: from white ([5.194.185.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4886876c027sm14791908f8f.17.2026.09.24.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:49:17 -0700 (PDT)
From: "Denis Efremov (Oracle)" <efremov@linux.com>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Denis Efremov (Oracle)" <efremov@linux.com>,
	stable@vger.kernel.org,
	syzbot+874c2707f97fac24b090@syzkaller.appspotmail.com
Subject: [PATCH] floppy: don't store a stack buffer in timeout_message
Date: Thu, 24 Sep 2026 13:48:39 +0400
Message-ID: <20260924094839.3239569-1-efremov@linux.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

request_done() formats "request done %d" into a buffer on its stack and
passes it to reschedule_timeout(), which keeps the pointer in
timeout_message. show_floppy() prints timeout_message long after
request_done() has returned, e.g. from result() in the interrupt
handler, and reads a dead stack frame:

  BUG: KASAN: stack-out-of-bounds in string+0x39c/0x3d0 lib/vsprintf.c:720
  Read of size 1 at addr ffffc900003cfc70 by task swapper/3/0
  Call Trace:
   <IRQ>
   ...
   show_floppy+0xb1/0x45f drivers/block/floppy.c:1838
   result.cold+0x2b/0x30 drivers/block/floppy.c:1183
   floppy_interrupt+0x191/0x340 drivers/block/floppy.c:1755
   floppy_hardint+0x1a7/0x200 arch/x86/include/asm/floppy.h:66

uptodate is either 0 or 1, so pass one of two string literals instead.

Cc: stable@vger.kernel.org
Fixes: 73507e6cd8dc ("drivers/block/floppy.c: remove unnecessary argument from [__]reschedule_timeout")
Reported-by: syzbot+874c2707f97fac24b090@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=874c2707f97fac24b090
Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
---
 drivers/block/floppy.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..02a34de69102 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2276,11 +2276,10 @@ static void request_done(int uptodate)
 {
 	struct request *req = current_req;
 	int block;
-	char msg[sizeof("request done ") + sizeof(int) * 3];
 
 	probing = 0;
-	snprintf(msg, sizeof(msg), "request done %d", uptodate);
-	reschedule_timeout(MAXTIMEOUT, msg);
+	reschedule_timeout(MAXTIMEOUT,
+			   uptodate ? "request done 1" : "request done 0");
 
 	if (!req) {
 		pr_info("floppy.c: no request in request_done\n");

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.55.0

