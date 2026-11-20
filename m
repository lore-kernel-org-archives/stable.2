Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795192541;
	b=G+bSCoXsYy780RvslLGeC0qMskV/HeRMvrBGT6gHlq/O+58CQFK1+114AXZ101FnJKrR
	 y1Fn9rILK2aSuryqsBQydtJwWqoATnj5XNa+6pezMUeXlIujsFZv0uLLOAz6LrHVRsk/z
	 g6zX7RT4A61TQnfw+fj8LPl4RkfQWi6Hn1m5HUqgSBOdjVtj6DNNmUWN9LNxl7LJ2jJHk
	 vCXrGKNzozPsvG8LuPkE8iBF55rm3H5VT7K8tW4h7iekulfg7vUmaJ+mWpMm1lAqA2Tn7
	 NT5VG5CC4wUKvxgvYXPeo/fIs7fwFSVQ4OKBTIC//ryxdDvCpzOdtOHdc2G3xe/cwZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192541;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=cqX+HBaiyRku0wym2/6h6j8L9vuI5c+H4DFEoHY9HEc=;
	b=MC7wmqvOGo19Sz9PigS5bIVhK+e8Jx2KbFLbC3JfnUSoychzemaYKgBGrxE0wDh1aoAI
	 /EN0vpUuIH1gZXWVqYdGwClQprkZmrO6BqDKZmLHvb58hdanK739tTvlFFUFvZ0yBy12G
	 JWGm3tIYeHlwgQ21Stkm19T9YcMrDHa02SzmMmuo3v7UlGvs8t0Nnc5JLl58Xg98jMVn8
	 sdCTaO76RGq0UDOn87nAB1G3PfQMABFV+J+qs1TBuJNHomL+t+/87And4Zt+T0Zl+JQlu
	 hTCY8t9OGPjVbWV5QUq1jKcclhgrv+3Z4/1IBXcUfkoz4dGmhacMgSpca3DCk6tyKKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1908D60A260B;
	Fri, 20 Nov 2026 16:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1908D60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=cqX+HBaiyRku0wym2/6h6j8L9vuI5c+H4D
	FEoHY9HEc=; b=QTmW1NdFdwPLolUy4u6UXSkUcGAEgyd7JVxtg3Etp3Um0h/OcH
	QyBk8Y+Gg+Clt3rgp9b6TdWiRoBwVtyWvaQRM7U9VkeihQtzXeWzt3u6jpyYWfvP
	VBkeJ0BjRof61RMryOCl7pEX7edZ3IoLWyK5qsNtT3VU9txfO2MGIVGrU=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkAmKv3NdgBrMA_0AQ--.38349S2;
	Sat, 21 Nov 2026 00:35:26 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] usb: ljca: fix NULL pointer dereference on events for callback-less clients
Date: Sat, 21 Nov 2026 00:35:24 +0800
Message-Id: <20261120163524.2994-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026112045-napping-suitcase-26b0@gregkh>
References: <2026112045-napping-suitcase-26b0@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:BbQMCkAmKv3NdgBrMA_0AQ--.38349S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4kCF47Wry3JF15Wry8Krg_yoW8tF4kpF
	W5KFyFk3Wkt3Z2v39Ivr4UtF1fAF4vq3y8Cr10g348Kan8GFyftFy3Kw1Ygay3Xws3Z3y2
	ya1Yqry3C34qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUkl4iDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUDD2sAYlgUOwAAs2

On Fri, Nov 20, 2026 at 05:06:20PM +0100, Greg Kroah-Hartman wrote:=0D
> > A device that sends a message without LJCA_ACK_FLAG and with the type o=
f=0D
> > such a client therefore makes the driver call a NULL function pointer=0D
> > from the URB completion handler:=0D
>=0D
> What device does that?  How?=0D
=0D
The link carries one message per bulk-IN transfer, laid out as {type, cmd,=
=0D
flags, len, data}.  ljca_recv() decides whether a message is an=0D
acknowledgement or an event from bit 0 of flags alone, and ljca_handle_even=
t()=0D
then dispatches events by type only.  The I2C (type 4) and SPI (type 5)=0D
clients are created during enumeration and never call ljca_register_event_c=
b(),=0D
so their event_cb stays NULL for as long as the adapter is bound.=0D
=0D
A device answering an ordinary I2C command (cmd 3..6, START/STOP/READ/WRITE=
)=0D
answers with flags =3D LJCA_CMPL_FLAG | LJCA_ACK_FLAG =3D 0x05.  Clearing b=
it 0 of=0D
that byte, one bit, turns the very same reply into an event: {type =3D 0x04=
,=0D
cmd =3D 0x03, flags =3D 0x00, len =3D 0x03}.  That matches the report exact=
ly: cmd=0D
3/4/5/6, len 3 for the short replies and 3+N for READ.  So any device that=
=0D
emits such a message, be it buggy firmware or a device that does not implem=
ent=0D
the protocol exactly, oopses the kernel from the URB completion handler.=0D
=0D
> How was this tested, shouldn't the driver be fixed up not to do that=0D
> instead of this workaround?=0D
=0D
The callback is optional by design: ljca_register_event_cb() is how a clien=
t=0D
opts in, and the comment in ljca_handle_event() notes that only GPIO regist=
ers=0D
one.  What is missing is that the dispatcher does not honour that contract,=
 it=0D
matches on type alone and calls whatever is there.  The patch makes the=0D
dispatch deliver events only to clients that registered for them, which is =
the=0D
driver being fixed up to do what its own API promises.=0D
=0D
The alternatives look worse: a no-op callback in the I2C and SPI clients (f=
ake=0D
handlers), keeping those clients out of the list (they are needed for=0D
transfers), or validating event types in ljca_recv() (the type space belong=
s to=0D
the firmware, the driver has no table of valid event types).=0D
=0D
Testing: compiled with CONFIG_USB_LJCA=3Dy, CONFIG_GPIO_LJCA=3Dy and=0D
CONFIG_I2C_LJCA=3Dy; the oops above is from 7.3.1 with a device sending tha=
t=0D
message.=0D
=0D
thanks,=0D

